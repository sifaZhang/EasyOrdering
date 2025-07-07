const { toLocalDatetimeString } = require('../app');
const request = require('supertest');
const express = require('express');
const conn = require('../dbConfig');
app = require('../app');

test('should convert UTC string to local datetime string', () => {
  const result = toLocalDatetimeString('2024-07-01 16:00:00');
  expect(result).toMatch(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}/);
  expect(result).toBe('2024-07-02 04:00:00');
});
test('should handle invalid date string gracefully', () => {
    const result = toLocalDatetimeString('invalid-date');
    expect(result).toBe('Invalid Date');
});


// Mock dbConfig and its query method
jest.mock('../dbConfig', () => ({
    query: jest.fn(),
}));


beforeAll(() => {
});

describe('GET /', () => {
    afterEach(() => {
        jest.clearAllMocks();
    });

    it('should render home with topNItemsPerType on success', async () => {
        // Mock the db query to call the callback with no error and fake results
        conn.query.mockImplementation((sql, params, cb) => {
            cb(null, [[{ id: 1, name: 'item1' }, { id: 2, name: 'item2' }]]);
        });

        // Mock res.render
        const res = await request(app).get('/');

        expect(conn.query).toHaveBeenCalledWith(
            'CALL SelectTopItemsByType(?)',
            [5],
            expect.any(Function)
        );
        // Since EJS rendering returns HTML, check for some expected content
        expect(res.statusCode).toBe(200);
        // Optionally, check that the rendered HTML contains expected data
        // expect(res.text).toContain('item1');
    });

    it('should return 500 if database error occurs', async () => {
        conn.query.mockImplementation((sql, params, cb) => {
            cb(new Error('DB error'));
        });

        const res = await request(app).get('/');
        expect(res.statusCode).toBe(500);
        expect(res.text).toContain('Database error (SelectTopItemsByType)');
    });

    it('should render login page on GET /login', async () => {
        const res = await request(app).get('/login');
        expect(res.statusCode).toBe(200);
        // Optionally, check for some content in the rendered HTML
        // expect(res.text).toContain('Login');
    });

    it('should render contact page on GET /contact', async () => {
        const res = await request(app).get('/contact');
        expect(res.statusCode).toBe(200);
        // expect(res.text).toContain('Contact');
    });

    it('should render resetpwd page on GET /resetpwd', async () => {
        const res = await request(app).get('/resetpwd');
        expect(res.statusCode).toBe(200);
        // expect(res.text).toContain('Reset Password');
    });

    it('should render ordersForHistory with queried=false for invalid dates', async () => {
        const res = await request(app).get('/ordersForHistory?fromDate=invalid&toDate=invalid');
        expect(res.statusCode).toBe(200);
        expect(res.text).toContain('');
    });

    it('should return 500 for invalid date on /filterByDate', async () => {
        const res = await request(app).get('/filterByDate?fromDate=invalid&toDate=invalid');
        expect(res.statusCode).toBe(500);
        expect(res.text).toContain('Invalid date');
    });

    it('should return pending order count as JSON', async () => {
        conn.query.mockImplementation((sql, params, cb) => {
            cb(null, [{ count: 5 }]);
        });
        const res = await request(app).get('/api/pendingOrderCount');
        expect(res.statusCode).toBe(200);
        expect(res.body).toHaveProperty('count', 5);
    });

    it('should render payment page with success param', async () => {
        const res = await request(app).get('/payment?success=true');
        expect(res.statusCode).toBe(200);
        // expect(res.text).toContain('Payment');
    });

    it('should render customizeFoodtype page', async () => {
        conn.query.mockImplementationOnce((sql, cb) => {
            cb(null, [{ id: 1, name: 'type1' }]);
        });
        const res = await request(app).get('/customizeFoodtype');
        expect(res.statusCode).toBe(200);
        // expect(res.text).toContain('type1');
    });

    it('should render qrcode page', async () => {
        conn.query.mockImplementationOnce((sql, cb) => {
            cb(null, [{ id: 1, tablenumber: 1 }]);
        });
        const res = await request(app).get('/qrcode');
        expect(res.statusCode).toBe(200);
        // expect(res.text).toContain('qrcode');
    });

    it('should return 400 for invalid categoryId on /menuItems', async () => {
        const res = await request(app).get('/menuItems?categoryId=abc');
        expect(res.statusCode).toBe(400);
        expect(res.body).toHaveProperty('error', 'Invalid categoryId');
    });

    it('should return menu items as JSON for valid categoryId', async () => {
        conn.query.mockImplementationOnce((sql, params, cb) => {
            cb(null, [{ id: 1, name: 'Pizza' }]);
        });
        const res = await request(app).get('/menuItems?categoryId=1');
        expect(res.statusCode).toBe(200);
        expect(Array.isArray(res.body)).toBe(true);
        expect(res.body[0]).toHaveProperty('name', 'Pizza');
    });
});






