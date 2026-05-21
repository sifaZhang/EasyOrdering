-- ============================================================
-- PostgreSQL version of easyordering database
-- Cleaned version - only valid order_items
-- ============================================================

BEGIN;

-- --------------------------------------------------------
-- Table: user_type
-- --------------------------------------------------------
CREATE TABLE user_type (
    id INTEGER PRIMARY KEY,
    type VARCHAR(50) NOT NULL
);

INSERT INTO user_type (id, type) VALUES
(1, 'Administrator'),
(2, 'Receptionist'),
(3, 'Customer');

-- --------------------------------------------------------
-- Table: order_status
-- --------------------------------------------------------
CREATE TABLE order_status (
    id INTEGER PRIMARY KEY,
    status VARCHAR(50) NOT NULL
);

INSERT INTO order_status (id, status) VALUES
(11, 'pending'),
(12, 'confirmed'),
(13, 'preparing'),
(14, 'ready'),
(15, 'completed'),
(17, 'cancelled');

-- --------------------------------------------------------
-- Table: deleted_images
-- --------------------------------------------------------
CREATE TABLE deleted_images (
    id SERIAL PRIMARY KEY,
    image_path VARCHAR(255) NOT NULL
);

INSERT INTO deleted_images (id, image_path) VALUES
(25, '/uploads/1752473505302-767206623.jpg'),
(26, '/QRCodes/table9.png'),
(27, '/uploads/1752549158537-944334333.jpg'),
(28, '/QRCodes/table9.png'),
(29, '/uploads/1752550817852-143570631.jpg'),
(30, '/QRCodes/table9.png'),
(31, '/QRCodes/table9.png'),
(32, '/uploads/1752553313219-50620599.jpg'),
(33, '/uploads/1752558773271-952780372.jpg'),
(34, '/QRCodes/table9.png'),
(35, '/QRCodes/table10.png'),
(36, '/QRCodes/table9.png'),
(37, '/uploads/1752561449850-446882743.jpg'),
(38, '/uploads/1752561612331-249455561.png');

-- --------------------------------------------------------
-- Table: food_type
-- --------------------------------------------------------
CREATE TABLE food_type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    creator VARCHAR(100) NOT NULL,
    createtime TIMESTAMP NOT NULL,
    available BOOLEAN NOT NULL,
    "showOrder" FLOAT NOT NULL
);

INSERT INTO food_type (id, name, creator, createtime, available, "showOrder") VALUES
(3, 'Starters', 'Admin', '2025-07-15 07:51:34', TRUE, 1),
(4, 'Main Courses', 'Admin', '2025-07-15 07:51:36', TRUE, 2),
(5, 'Desserts', 'Admin', '2025-07-13 03:20:45', TRUE, 4),
(6, 'Beverages', 'Admin', '2025-07-13 03:20:41', TRUE, 6),
(7, 'Sides', 'Admin', '2025-07-13 03:20:44', TRUE, 5),
(8, 'Vegetarian', 'Admin', '2025-07-13 03:20:39', FALSE, 7),
(9, 'Chef''s Tasting Menu', 'Admin', '2025-07-15 07:51:36', FALSE, 3);

-- --------------------------------------------------------
-- Table: users
-- --------------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    usertype INTEGER NOT NULL REFERENCES user_type(id),
    creator VARCHAR(100) NOT NULL,
    createtime TIMESTAMP NOT NULL
);

INSERT INTO users (id, username, firstname, lastname, password, email, phone, usertype, creator, createtime) VALUES
(1, 'Admin', 'Sifa', 'Zhang', '666', 'easyerordering@gmail.com', '0210408866', 1, 'Admin', '2025-06-12 11:54:00'),
(6, 'Serena', 'Serena', 'Jia', '666', 'serena@gmail.com', '021555666', 1, 'Admin', '2025-06-23 07:31:43'),
(14, 'Tom', 'Tom', 'Jia', '1', 'sifadd@gmail.com', '0210408603', 2, 'Admin', '2025-07-13 08:37:20'),
(15, 'Jack', 'Jack', 'Jia', '2', 'tariq@yahoo.com', '0210408606', 2, 'Admin', '2025-07-13 08:37:48');

-- --------------------------------------------------------
-- Table: menu
-- --------------------------------------------------------
CREATE TABLE menu (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    foodtype INTEGER NOT NULL REFERENCES food_type(id) ON DELETE CASCADE,
    description VARCHAR(200) NOT NULL,
    picture VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    discount INTEGER NOT NULL,
    creator VARCHAR(100) NOT NULL,
    createtime TIMESTAMP NOT NULL,
    available BOOLEAN NOT NULL
);

INSERT INTO menu (id, name, foodtype, description, picture, price, discount, creator, createtime, available) VALUES
(1, 'Beef Carpaccio', 3, 'Thinly sliced raw beef served with arugula, Parmesan, and truffle oil. A refined and elegant starter.', '/uploads/1749964334093-738947418.jpg', 12.5, 50, 'Admin', '2025-07-07 03:28:39', TRUE),
(3, 'Smoked Salmon', 3, 'Cold-smoked Atlantic salmon, crème fraîche, pickled shallots, dill, with dark rye toast.', '/uploads/1749974308452-211316530.jpg', 21.5, 0, 'Admin', '2025-06-15 07:58:28', TRUE),
(4, 'Baked Brie with Honeyed Figs', 3, 'Creamy French brie oven-baked to molten perfection, crowned with caramelized figs in spiced honey and crushed walnuts. Served with artisan sourdough crisps.', '/uploads/1749974618266-101225929.jpg', 18.8, 0, 'Admin', '2025-06-15 08:03:38', TRUE),
(5, 'Parma Ham with Melon', 3, 'Paper-thin slices of 24-month aged Parma ham (DOP) draped over chilled cantaloupe, finished with aged balsamic pearls and fresh mint', '/uploads/1749974692183-611352766.jpg', 16.6, 10, 'Admin', '2025-06-15 08:04:52', TRUE),
(6, 'Oysters on the Half Shell', 3, 'Freshly shucked East Coast oysters served chilled over ice with classic mignonette sauce, lemon wedges, and horseradish.', '/uploads/1749974851254-268760414.jpg', 28.9, 20, 'Admin', '2025-06-24 02:28:00', TRUE),
(8, 'Butter-Poached Maine Lobster', 4, 'Succulent Maine lobster tail slow-cooked in clarified butter, finished with a citrus-herb emulsion. Served atop saffron risotto with micro chervil.', '/uploads/1749975065244-811432500.jpg', 188.99, 0, 'Admin', '2025-06-15 08:11:05', TRUE),
(9, 'Beef Wellington', 4, 'An iconic British masterpiece featuring center-cut beef tenderloin wrapped in wild mushroom duxelles, prosciutto di Parma, and flaky puff pastry. Baked golden and served with Madeira demi-glace.', '/uploads/1749975157629-812969773.jpg', 58.88, 0, 'Admin', '2025-06-15 08:12:37', TRUE),
(10, 'Wild Mushroom Risotto', 4, 'Carnaroli rice slowly cooked in porcini mushroom broth with a medley of foraged chanterelles, morels, and black trumpets. Finished with white truffle oil and aged Parmigiano-Reggiano.', '/uploads/1749975356541-732411461.jpg', 26.68, 20, 'Admin', '2025-06-15 08:15:56', TRUE),
(11, 'Truffle Roasted Chicken', 4, 'Free-range corn-fed chicken supreme stuffed with black truffle mousse under the skin, roasted to golden perfection and served with truffle jus. Accompanied by pomme purée and seasonal wild mushrooms.', '/uploads/1749975498830-428297761.jpg', 48.6, 0, 'Admin', '2025-06-15 08:18:18', TRUE),
(12, 'Herb-Crusted Rack of Lamb', 4, 'New Zealand grass-fed lamb rack encased in a crisp crust of rosemary, thyme, Dijon mustard and sourdough breadcrumbs, roasted pink and served with mint-infused jus. Accompanied by dauphinoise potatoes', '/uploads/1749975625522-293355658.jpg', 69.99, 0, 'Admin', '2025-06-15 08:20:56', TRUE),
(13, 'Strawberry Mille-Feuille', 5, 'Layers of crisp caramelized puff pastry sandwiching vanilla-infused mascarpone cream and fresh Scottish strawberries, finished with a balsamic reduction and edible gold leaf.', '/uploads/1749975807206-747636628.jpg', 22.88, 0, 'Admin', '2025-06-15 08:23:27', TRUE),
(14, 'Mango-Coconut Sphere', 5, 'A modern tropical dessert featuring a delicate coconut mousse sphere encasing Alphonso mango purée, served on passionfruit coulis with toasted coconut flakes and lemongrass foam.', '/uploads/1749975919154-209273190.png', 20.66, 0, 'Admin', '2025-06-15 08:25:19', TRUE),
(15, 'Sticky Toffee Pudding', 5, 'The ultimate British comfort dessert - moist date sponge soaked in butterscotch sauce, served warm with clotted cream ice cream and candied pecans.', '/uploads/1749975990794-8547847.jpg', 18.88, 10, 'Admin', '2025-06-15 08:26:30', TRUE),
(16, 'Chocolate Lava Cake', 5, 'A symphony of temperature and texture - warm Valrhona Guanaja 70% chocolate cake with a molten core, served with Madagascar vanilla bean ice cream and raspberry coulis.', '/uploads/1749976129410-337856577.jpg', 19.99, 20, 'Admin', '2025-06-15 08:28:49', TRUE),
(17, 'Crème Brûlée', 5, 'The quintessential French dessert - silky vanilla custard beneath a glass-like caramelized sugar crust, served in its traditional ceramic dish.', '/uploads/1749976217175-419072657.jpg', 12.66, 0, 'Admin', '2025-06-15 08:30:17', TRUE),
(18, 'The Perfect Martini', 6, 'A crystalline celebration of gin and vermouth in mathematically precise harmony, served at -8°C in a hand-chilled coupe glass.', '/uploads/1749976356128-122600691.jpg', 8.8, 0, 'Admin', '2025-06-15 08:32:36', TRUE),
(19, 'Espresso', 6, 'The purest expression of coffee - a 30ml concentrated elixir extracted under 9 bars of pressure, crowned with a tiger-striped crema.', '/uploads/1749976525748-699015948.jpg', 6.6, 0, 'Admin', '2025-06-15 08:35:25', TRUE),
(20, 'Cappuccino', 6, 'The zenith of coffee alchemy - a perfectly balanced trilogy of intense espresso, velvety steamed milk, and cloud-like microfoam in strict 1:1:1 harmony.', '/uploads/1749976578010-232584546.jpg', 6.8, 10, 'Admin', '2025-06-15 08:36:18', TRUE),
(21, 'Flat White', 6, 'The barista''s ultimate technical showcase - a double ristretto (18-20g) melded with steamed whole milk into a 160ml velvety emulsion, achieving the "holy grail" microfoam thickness of 1mm.', '/uploads/1749976668139-661629930.jpg', 5.8, 20, 'Admin', '2025-06-15 08:37:48', TRUE),
(23, 'Château Lafite Rothschild', 6, 'The epitome of First Growth elegance - Pauillac''s most ethereal Cabernet-dominant blend, where power and finesse achieve perfect equilibrium.', '/uploads/1749976967155-361276090.jpg', 999.99, 10, 'Admin', '2025-06-15 08:42:47', TRUE),
(24, 'Barolo DOCG', 6, 'The "King of Wines" from Piedmont - 100% Nebbiolo aged in Slovenian oak, expressing the terroir of Langhe''s limestone-clay soils.', '/uploads/1749977029486-196464645.jpg', 488.88, 20, 'Admin', '2025-06-15 08:43:49', TRUE),
(25, 'Shepherd''s Pie', 4, 'The ultimate British comfort classic - slow-braised lamb in red wine gravy beneath a cloud of buttery mashed potatoes, baked to golden perfection.', '/uploads/1749977170292-818641156.jpeg', 48.88, 10, 'Admin', '2025-06-15 08:46:10', TRUE),
(26, 'Truffle Fries', 7, 'Hand-cut, duck fat double-fried, dusted with black truffle salt & Parmigiano', '/uploads/1749977351307-421838228.jpg', 6.9, 0, 'Admin', '2025-06-15 08:49:11', TRUE),
(27, 'Dauphinoise Potatoes', 7, 'Layered with garlic cream, baked golden', '/uploads/1749977423021-742360594.jpg', 9.8, 10, 'Admin', '2025-06-15 08:50:23', TRUE),
(28, 'Crispy Brussels Sprouts', 7, 'Caramelized with bacon-maple glaze, pomegranate seeds', '/uploads/1749977499042-636887129.jpg', 12.5, 20, 'Admin', '2025-06-15 08:51:39', TRUE),
(29, 'French Lentils', 7, 'Duck stock-infused, herb de Provence', '/uploads/1749977609467-232404965.jpg', 7.8, 0, 'Admin', '2025-06-15 08:53:29', TRUE),
(30, 'Truffle Mac & Cheese', 7, '3-cheese blend, black truffle breadcrumbs', '/uploads/1749977691059-653340250.jpg', 10.8, 0, 'Admin', '2025-06-15 08:54:51', TRUE),
(44, '6', 4, '6', '/uploads/1750119388735-110172635.jpg', 6, 6, 'Admin', '2025-07-07 03:23:04', TRUE),
(51, '88', 5, '44', '/uploads/1750924828272-830877506.jpg', 4, 0, 'Admin', '2025-06-26 08:00:40', TRUE);

-- --------------------------------------------------------
-- Table: orders
-- --------------------------------------------------------
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    status INTEGER NOT NULL REFERENCES order_status(id),
    ordertime TIMESTAMP NOT NULL,
    finishtime TIMESTAMP,
    tablenumber INTEGER NOT NULL,
    creator VARCHAR(100) NOT NULL,
    paid BOOLEAN NOT NULL
);

INSERT INTO orders (id, status, ordertime, finishtime, tablenumber, creator, paid) VALUES
(4, 15, '2025-06-19 05:38:58', '2025-06-22 08:01:48', 8, '1750311537334657', TRUE),
(5, 15, '2025-06-22 08:11:06', '2025-06-22 08:12:15', 8, '175057984151836', TRUE),
(6, 15, '2025-06-22 08:15:44', '2025-06-22 08:16:23', 6, '1750580139768166', TRUE),
(7, 15, '2025-06-22 08:27:05', '2025-06-22 08:43:00', 5, '1750580822873787', TRUE),
(8, 15, '2025-06-23 03:56:37', '2025-06-23 05:26:37', 8, '1750650995173615', TRUE),
(9, 15, '2025-06-23 05:09:49', '2025-06-23 05:39:08', 6, '1750655343208760', TRUE),
(10, 15, '2025-06-23 05:39:58', '2025-06-23 05:40:09', 8, '1750657182728111', TRUE),
(11, 15, '2025-06-23 05:41:48', '2025-06-23 05:42:19', 8, '1750657305180110', TRUE),
(12, 15, '2025-06-23 05:43:52', '2025-06-23 05:44:04', 6, '1750657429752117', TRUE),
(13, 15, '2025-06-24 02:14:51', '2025-06-24 02:15:12', 2, '1750731287234409', TRUE),
(14, 15, '2025-06-26 08:05:08', '2025-06-26 08:05:50', 9, '1750925089773456', TRUE),
(22, 15, '2025-06-26 23:36:38', '2025-06-26 23:37:25', 7, '1750980996594617', TRUE),
(24, 15, '2025-06-27 00:33:36', '2025-06-27 00:33:54', 3, 'Sifa', TRUE),
(25, 15, '2025-06-27 01:38:56', '2025-06-28 06:17:55', 6, 'Sifa', TRUE),
(27, 15, '2025-06-28 06:32:15', '2025-06-28 06:42:42', 6, '175109232681861', TRUE),
(28, 17, '2025-06-29 02:14:58', NULL, 7, 'Sifa', TRUE),
(29, 15, '2025-06-29 02:20:33', '2025-06-29 02:25:31', 6, 'Sifa', TRUE),
(31, 17, '2025-06-29 02:39:54', NULL, 5, 'Sifa', TRUE),
(33, 15, '2025-06-29 03:09:49', NULL, 5, 'Sifa', TRUE),
(34, 17, '2025-06-29 03:14:22', NULL, 5, 'Sifa', TRUE),
(35, 17, '2025-06-29 03:29:24', NULL, 5, 'Sifa', TRUE),
(38, 17, '2025-06-29 03:39:25', NULL, 3, 'Sifa', TRUE),
(39, 17, '2025-06-29 03:40:49', NULL, 1, 'Sifa', TRUE),
(40, 17, '2025-06-29 03:43:20', NULL, 2, 'Sifa', TRUE),
(42, 15, '2025-06-29 03:44:29', NULL, 4, 'Sifa', TRUE),
(49, 15, '2025-06-29 05:44:24', '2025-06-29 07:34:26', 3, 'Sifa', TRUE),
(50, 15, '2025-06-29 06:03:41', '2025-06-29 07:34:24', 1, 'Sifa', TRUE),
(52, 15, '2025-06-29 07:25:42', '2025-06-29 07:34:29', 5, '1751181939739649', TRUE),
(53, 15, '2025-06-29 07:36:37', '2025-06-29 07:44:40', 5, '1751182594429948', TRUE),
(54, 17, '2025-06-29 07:44:52', '2025-06-29 07:45:11', 7, '1751183090206180', TRUE),
(56, 15, '2025-07-06 22:09:57', '2025-07-06 23:51:06', 5, '1751839795318865', TRUE),
(57, 15, '2025-07-06 23:51:51', '2025-07-06 23:52:05', 6, '1751845878050538', TRUE),
(58, 15, '2025-07-07 04:36:15', '2025-07-07 05:22:33', 6, '1751860405346464', TRUE),
(61, 17, '2025-07-07 08:12:35', '2025-07-07 08:13:13', 0, '1751875784806280', TRUE),
(63, 15, '2025-07-08 03:46:52', '2025-07-08 03:47:24', 6, 'Sifa', TRUE),
(64, 15, '2025-07-08 03:56:39', '2025-07-08 03:57:38', 6, 'Sifa', TRUE),
(67, 17, '2025-07-08 21:48:17', '2025-07-08 21:59:53', 7, 'Sifa', TRUE),
(68, 15, '2025-07-08 22:00:53', '2025-07-08 22:06:33', 7, 'Sifa', TRUE),
(69, 15, '2025-07-08 22:01:44', '2025-07-08 22:05:58', 7, '1752012074312260', TRUE),
(71, 15, '2025-07-08 22:09:52', '2025-07-08 22:11:16', 5, 'Sifa', TRUE),
(72, 15, '2025-07-08 22:10:07', '2025-07-08 22:11:15', 2, 'Sifa', TRUE),
(73, 15, '2025-07-08 22:10:28', '2025-07-08 22:11:18', 5, 'Sifa', TRUE),
(81, 15, '2025-07-13 00:51:31', '2025-07-13 04:43:22', 7, '1752367887543286', TRUE),
(82, 15, '2025-07-13 03:25:57', '2025-07-13 04:45:43', 8, '1752377153306942', TRUE),
(83, 15, '2025-07-13 23:29:15', '2025-07-13 23:58:56', 6, '1752449352127771', TRUE),
(84, 15, '2025-07-13 23:59:27', '2025-07-14 00:27:24', 3, '175245116563118', TRUE),
(85, 15, '2025-07-14 00:28:31', '2025-07-14 00:34:18', 5, '1752452908279962', TRUE),
(86, 15, '2025-07-14 04:58:28', '2025-07-14 05:02:56', 9, '175246908519171', TRUE),
(87, 15, '2025-07-14 05:15:44', '2025-07-14 05:38:44', 9, '1752470108874620', TRUE),
(88, 15, '2025-07-14 06:16:42', '2025-07-14 06:25:56', 9, '175247378327985', TRUE),
(90, 15, '2025-07-15 03:21:47', '2025-07-15 03:28:37', 9, '1752549677453470', TRUE),
(91, 15, '2025-07-15 03:44:09', '2025-07-15 03:51:51', 9, '1752551029861452', TRUE),
(92, 15, '2025-07-15 04:25:19', '2025-07-15 04:34:15', 9, '1752553490358947', TRUE),
(93, 15, '2025-07-15 05:58:02', '2025-07-15 06:54:25', 9, '1752559056802655', TRUE);

-- --------------------------------------------------------
-- Table: order_items (只保留有效的 orderid)
-- --------------------------------------------------------
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    itemid INTEGER NOT NULL,
    itemname VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    discount INTEGER NOT NULL,
    itemnumber INTEGER NOT NULL,
    status INTEGER NOT NULL REFERENCES order_status(id),
    orderid INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE
);

INSERT INTO order_items (id, itemid, itemname, price, discount, itemnumber, status, orderid) VALUES
(12, 23, 'Château Lafite Rothschild', 999.99, 10, 1, 15, 4),
(15, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 4),
(17, 25, 'Shepherd''s Pie', 48.88, 10, 1, 15, 4),
(19, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 4),
(27, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 2, 15, 4),
(30, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 4),
(32, 3, 'Smoked Salmon', 21.5, 0, 3, 15, 4),
(37, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 4),
(38, 13, 'Strawberry Mille-Feuille', 22.88, 0, 1, 15, 5),
(39, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 5),
(40, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 5),
(41, 16, 'Chocolate Lava Cake', 19.99, 20, 1, 15, 5),
(42, 17, 'Crème Brûlée', 12.66, 0, 1, 15, 5),
(43, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 5),
(44, 28, 'Crispy Brussels Sprouts', 12.5, 20, 1, 15, 5),
(45, 29, 'French Lentils', 7.8, 0, 1, 15, 5),
(46, 30, 'Truffle Mac & Cheese', 10.8, 0, 1, 15, 5),
(47, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 5),
(48, 19, 'Espresso', 6.6, 0, 1, 15, 5),
(49, 20, 'Cappuccino', 6.8, 10, 1, 15, 5),
(50, 21, 'Flat White', 5.8, 20, 1, 15, 5),
(51, 25, 'Shepherd''s Pie', 48.88, 10, 1, 15, 5),
(52, 12, 'Herb-Crusted Rack of Lamb', 69.99, 0, 1, 15, 5),
(53, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 5),
(54, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 5),
(55, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 5),
(56, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 6),
(57, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 6),
(58, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 6),
(59, 9, 'Beef Wellington', 58.88, 0, 1, 15, 6),
(60, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 6),
(61, 11, 'Truffle Roasted Chicken', 48.6, 0, 1, 15, 6),
(62, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 6),
(63, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 6),
(64, 16, 'Chocolate Lava Cake', 19.99, 20, 1, 15, 6),
(65, 26, 'Truffle Fries', 6.9, 0, 1, 15, 6),
(66, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 6),
(67, 29, 'French Lentils', 7.8, 0, 1, 15, 6),
(68, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 6),
(69, 19, 'Espresso', 6.6, 0, 1, 15, 6),
(70, 20, 'Cappuccino', 6.8, 10, 1, 15, 6),
(73, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 7),
(74, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 7),
(75, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 7),
(76, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 7),
(77, 9, 'Beef Wellington', 58.88, 0, 1, 15, 7),
(78, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 7),
(79, 13, 'Strawberry Mille-Feuille', 22.88, 0, 1, 15, 7),
(80, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 7),
(81, 16, 'Chocolate Lava Cake', 19.99, 20, 1, 15, 7),
(82, 30, 'Truffle Mac & Cheese', 10.8, 0, 1, 15, 7),
(83, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 7),
(84, 19, 'Espresso', 6.6, 0, 1, 15, 7),
(85, 20, 'Cappuccino', 6.8, 10, 1, 15, 7),
(86, 21, 'Flat White', 5.8, 20, 1, 15, 7),
(87, 23, 'Château Lafite Rothschild', 999.99, 10, 1, 15, 7),
(88, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 7),
(89, 11, 'Truffle Roasted Chicken', 48.6, 0, 1, 15, 8),
(90, 12, 'Herb-Crusted Rack of Lamb', 69.99, 0, 1, 15, 8),
(91, 3, 'Smoked Salmon', 21.5, 0, 3, 15, 8),
(92, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 3, 15, 8),
(93, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 8),
(95, 20, 'Cappuccino', 6.8, 10, 1, 15, 8),
(96, 29, 'French Lentils', 7.8, 0, 1, 15, 8),
(97, 26, 'Truffle Fries', 6.9, 0, 1, 15, 8),
(98, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 9),
(99, 20, 'Cappuccino', 6.8, 10, 1, 15, 9),
(100, 24, 'Barolo DOCG', 488.88, 20, 1, 15, 9),
(101, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 9),
(102, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 9),
(103, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 10),
(104, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 10),
(105, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 11),
(106, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 11),
(107, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 12),
(108, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 13),
(109, 5, 'Parma Ham with Melon', 16.6, 10, 2, 15, 13),
(110, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 13),
(111, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 13),
(112, 1, 'Beef Carpaccio', 12.5, 0, 1, 15, 13),
(113, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 14),
(114, 9, 'Beef Wellington', 58.88, 0, 1, 15, 14),
(115, 12, 'Herb-Crusted Rack of Lamb', 69.99, 0, 2, 15, 14),
(124, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 22),
(125, 9, 'Beef Wellington', 58.88, 0, 1, 15, 22),
(128, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 24),
(129, 9, 'Beef Wellington', 58.88, 0, 1, 15, 24),
(130, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 25),
(134, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 27),
(135, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 17, 28),
(136, 9, 'Beef Wellington', 58.88, 0, 1, 17, 28),
(137, 44, '6', 6, 6, 1, 15, 29),
(139, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 29),
(140, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 29),
(141, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 29),
(149, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 33),
(150, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 33),
(151, 11, 'Truffle Roasted Chicken', 48.6, 0, 1, 17, 34),
(152, 9, 'Beef Wellington', 58.88, 0, 1, 17, 35),
(155, 9, 'Beef Wellington', 58.88, 0, 1, 17, 38),
(156, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 17, 39),
(157, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 17, 40),
(159, 9, 'Beef Wellington', 58.88, 0, 1, 15, 42),
(169, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 49),
(170, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 50),
(172, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 52),
(180, 28, 'Crispy Brussels Sprouts', 12.5, 20, 1, 15, 53),
(181, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 17, 54),
(182, 9, 'Beef Wellington', 58.88, 0, 1, 17, 54),
(183, 11, 'Truffle Roasted Chicken', 48.6, 0, 1, 17, 54),
(184, 44, '6', 6, 6, 1, 17, 54),
(190, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 56),
(191, 9, 'Beef Wellington', 58.88, 0, 1, 15, 56),
(192, 26, 'Truffle Fries', 6.9, 0, 1, 15, 56),
(193, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 56),
(194, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 56),
(195, 19, 'Espresso', 6.6, 0, 1, 15, 56),
(196, 6, 'Oysters on the Half Shell', 28.9, 20, 100, 15, 57),
(197, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 58),
(198, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 58),
(199, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 58),
(200, 12, 'Herb-Crusted Rack of Lamb', 69.99, 0, 1, 15, 58),
(201, 16, 'Chocolate Lava Cake', 19.99, 20, 1, 15, 58),
(202, 28, 'Crispy Brussels Sprouts', 12.5, 20, 1, 15, 58),
(208, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 58),
(210, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 58),
(224, 1, 'Beef Carpaccio', 12.5, 50, 1, 17, 61),
(225, 5, 'Parma Ham with Melon', 16.6, 10, 1, 17, 61),
(226, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 17, 61),
(233, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 63),
(234, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 64),
(235, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 64),
(237, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 64),
(238, 25, 'Shepherd''s Pie', 48.88, 10, 1, 15, 64),
(240, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 64),
(241, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 64),
(243, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 64),
(244, 18, 'The Perfect Martini', 8.8, 0, 1, 15, 64),
(245, 20, 'Cappuccino', 6.8, 10, 1, 15, 64),
(246, 23, 'Château Lafite Rothschild', 999.99, 10, 1, 15, 64),
(260, 1, 'Beef Carpaccio', 12.5, 50, 1, 17, 67),
(261, 3, 'Smoked Salmon', 21.5, 0, 1, 17, 67),
(262, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 17, 67),
(263, 5, 'Parma Ham with Melon', 16.6, 10, 1, 17, 67),
(264, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 17, 67),
(265, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 68),
(266, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 68),
(267, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 69),
(268, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 69),
(269, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 69),
(270, 9, 'Beef Wellington', 58.88, 0, 1, 15, 69),
(271, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 68),
(272, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 68),
(273, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 68),
(280, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 71),
(281, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 71),
(282, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 71),
(283, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 72),
(284, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 72),
(285, 25, 'Shepherd''s Pie', 48.88, 10, 1, 15, 73),
(286, 15, 'Sticky Toffee Pudding', 18.88, 10, 1, 15, 73),
(293, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 81),
(294, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 81),
(295, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 81),
(296, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 81),
(297, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 81),
(298, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 81),
(299, 17, 'Crème Brûlée', 12.66, 0, 1, 15, 81),
(300, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 81),
(301, 20, 'Cappuccino', 6.8, 10, 1, 15, 81),
(302, 21, 'Flat White', 5.8, 20, 1, 15, 81),
(306, 52, 'Fish', 20, 30, 1, 15, 82),
(307, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 82),
(308, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 82),
(309, 9, 'Beef Wellington', 58.88, 0, 1, 15, 82),
(311, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 82),
(312, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 82),
(313, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 83),
(314, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 83),
(315, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 84),
(316, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 84),
(317, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 84),
(318, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 85),
(319, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 85),
(320, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 85),
(321, 10, 'Wild Mushroom Risotto', 26.68, 20, 1, 15, 85),
(322, 11, 'Truffle Roasted Chicken', 48.6, 0, 1, 15, 85),
(323, 53, 'Fish', 20, 40, 1, 15, 86),
(324, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 86),
(325, 3, 'Smoked Salmon', 21.5, 0, 2, 15, 86),
(326, 14, 'Mango-Coconut Sphere', 20.66, 0, 1, 15, 86),
(327, 19, 'Espresso', 6.6, 0, 1, 15, 86),
(328, 54, 'Fish', 20, 50, 1, 15, 87),
(329, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 87),
(330, 3, 'Smoked Salmon', 21.5, 0, 2, 15, 87),
(331, 54, 'Fish', 20, 50, 1, 15, 87),
(332, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 87),
(333, 9, 'Beef Wellington', 58.88, 0, 1, 15, 87),
(334, 55, 'Fish', 20, 50, 1, 15, 88),
(335, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 88),
(337, 6, 'Oysters on the Half Shell', 28.9, 20, 1, 15, 88),
(338, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 88),
(339, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 88),
(340, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 88),
(346, 56, 'Fish', 20, 50, 1, 15, 90),
(347, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 90),
(348, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 90),
(349, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 90),
(351, 19, 'Espresso', 6.6, 0, 1, 15, 90),
(352, 20, 'Cappuccino', 6.8, 10, 1, 15, 90),
(353, 5, 'Parma Ham with Melon', 16.6, 10, 1, 15, 90),
(354, 8, 'Butter-Poached Maine Lobster', 188.99, 0, 1, 15, 90),
(355, 57, 'Fish', 20, 50, 1, 15, 91),
(356, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 91),
(357, 4, 'Baked Brie with Honeyed Figs', 18.8, 0, 1, 15, 91),
(358, 3, 'Smoked Salmon', 21.5, 0, 2, 15, 91),
(362, 20, 'Cappuccino', 6.8, 10, 1, 15, 91),
(363, 19, 'Espresso', 6.6, 0, 1, 15, 91),
(364, 58, 'Fish', 20, 50, 1, 15, 92),
(365, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 92),
(366, 3, 'Smoked Salmon', 21.5, 0, 1, 15, 92),
(368, 44, '6', 6, 6, 1, 15, 92),
(369, 27, 'Dauphinoise Potatoes', 9.8, 10, 1, 15, 92),
(370, 19, 'Espresso', 6.6, 0, 1, 15, 92),
(371, 20, 'Cappuccino', 6.8, 10, 1, 15, 92),
(372, 21, 'Flat White', 5.8, 20, 1, 15, 92),
(377, 60, 'Fish', 20, 50, 1, 15, 93),
(378, 61, 'Dessert', 5, 0, 1, 15, 93),
(379, 1, 'Beef Carpaccio', 12.5, 50, 1, 15, 93),
(381, 17, 'Crème Brûlée', 12.66, 0, 1, 15, 93),
(382, 30, 'Truffle Mac & Cheese', 10.8, 0, 1, 15, 93),
(383, 19, 'Espresso', 6.6, 0, 1, 15, 93);

-- 注意：删除了 orderid=15 的记录（原 id=71, 118 等）
-- 删除了 orderid=31 的记录（原没有，已确认不存在）

-- --------------------------------------------------------
-- Table: qrcode
-- --------------------------------------------------------
CREATE TABLE qrcode (
    tablenumber INTEGER PRIMARY KEY,
    picture VARCHAR(100) NOT NULL,
    creator VARCHAR(100) NOT NULL,
    createtime TIMESTAMP NOT NULL
);

INSERT INTO qrcode (tablenumber, picture, creator, createtime) VALUES
(1, '/QRCodes/table1.png', 'Admin', '2025-06-18 04:24:43'),
(2, '/QRCodes/table2.png', 'Admin', '2025-06-18 04:29:41'),
(3, '/QRCodes/table3.png', 'Admin', '2025-06-18 04:29:45'),
(4, '/QRCodes/table4.png', 'Admin', '2025-06-18 04:29:47'),
(5, '/QRCodes/table5.png', 'Admin', '2025-06-18 04:29:50'),
(6, '/QRCodes/table6.png', 'Admin', '2025-07-14 04:54:55'),
(7, '/QRCodes/table7.png', 'Admin', '2025-07-14 04:54:57'),
(8, '/QRCodes/table8.png', 'Admin', '2025-07-14 04:55:00');

-- --------------------------------------------------------
-- Table: reservations
-- --------------------------------------------------------
CREATE TABLE reservations (
    id SERIAL PRIMARY KEY,
    customername VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    date DATE,
    timeslot VARCHAR(20),
    tablenumber INTEGER,
    createdtime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO reservations (id, customername, phone, email, date, timeslot, tablenumber, createdtime) VALUES
(7, 'Serena', '0216666666', 'serena@gmail.com', '2025-07-11', '11:00', 4, '2025-07-10 11:25:21'),
(8, 'Serena', '0216666666', 'serena@gmail.com', '2025-07-11', '12:30', 4, '2025-07-10 11:25:23'),
(9, 'Serena', '0216666666', 'serena@gmail.com', '2025-07-11', '15:00', 4, '2025-07-10 11:25:25'),
(10, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-09', '11:00', 5, '2025-07-10 11:25:58'),
(11, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-09', '12:00', 5, '2025-07-10 11:25:59'),
(12, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-11', '11:00', 8, '2025-07-10 11:36:32'),
(13, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-09', '16:30', 6, '2025-07-10 11:39:53'),
(14, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-09', '13:00', 4, '2025-07-10 11:40:58'),
(21, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '13:30', 4, '2025-07-10 13:54:58'),
(22, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '11:30', 4, '2025-07-10 13:59:05'),
(23, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '11:00', 4, '2025-07-10 13:59:06'),
(24, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '14:00', 4, '2025-07-10 13:59:09'),
(25, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '11:00', 5, '2025-07-10 13:59:11'),
(26, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '11:30', 5, '2025-07-10 13:59:12'),
(27, 'Sifa', '0218888888', 'Sifazhang.nz@gmail.com', '2025-07-10', '12:00', 5, '2025-07-10 14:00:02'),
(29, 'Sifa', '0210408603', 'sifazhang.nz@gmail.com', '2025-07-15', '19:00', 9, '2025-07-14 17:17:24'),
(35, 'Sifa', '0210408603', 'sifazhang.nz@gmail.com', '2025-07-16', '11:00', 9, '2025-07-15 17:55:49'),
(36, 'Sifa', '0210408603', 'sifazhang.nz@gmail.com', '2025-07-16', '11:30', 9, '2025-07-15 17:55:55'),
(38, 'Sifa', '0210408603', 'sifazhang.nz@gmail.com', '2025-07-16', '12:30', 9, '2025-07-15 18:43:03');

-- --------------------------------------------------------
-- TRIGGERS
-- --------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_before_delete_foodtype()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO deleted_images (image_path)
    SELECT picture FROM menu WHERE foodtype = OLD.id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER before_delete_foodtype
BEFORE DELETE ON food_type
FOR EACH ROW EXECUTE FUNCTION fn_before_delete_foodtype();

CREATE OR REPLACE FUNCTION fn_before_delete_menu()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO deleted_images (image_path) VALUES (OLD.picture);
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER before_delete_menu
BEFORE DELETE ON menu
FOR EACH ROW EXECUTE FUNCTION fn_before_delete_menu();

CREATE OR REPLACE FUNCTION fn_before_order_delete()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM order_items WHERE orderid = OLD.id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER before_order_delete
BEFORE DELETE ON orders
FOR EACH ROW EXECUTE FUNCTION fn_before_order_delete();

CREATE OR REPLACE FUNCTION fn_update_order_items_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status != OLD.status THEN
        UPDATE order_items SET status = NEW.status WHERE orderid = NEW.id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_order_items_status
AFTER UPDATE ON orders
FOR EACH ROW EXECUTE FUNCTION fn_update_order_items_status();

CREATE OR REPLACE FUNCTION fn_order_items_status_update()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status <= OLD.status THEN
        NEW.status := OLD.status;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_order_items_status_update
BEFORE UPDATE ON order_items
FOR EACH ROW EXECUTE FUNCTION fn_order_items_status_update();

CREATE OR REPLACE FUNCTION fn_before_delete_qrcode()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO deleted_images (image_path)
    SELECT picture FROM qrcode WHERE tablenumber = OLD.tablenumber;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER before_delete_qrcode
BEFORE DELETE ON qrcode
FOR EACH ROW EXECUTE FUNCTION fn_before_delete_qrcode();

-- --------------------------------------------------------
-- VIEWS
-- --------------------------------------------------------

CREATE OR REPLACE VIEW menu_info AS
SELECT
    menu.id,
    menu.name,
    menu.foodtype,
    menu.description,
    menu.picture,
    menu.price,
    menu.discount,
    menu.creator,
    menu.createtime,
    food_type.name AS typename,
    menu.available AS "itemAvailable"
FROM menu
JOIN food_type ON menu.foodtype = food_type.id;

CREATE OR REPLACE VIEW users_info AS
SELECT
    users.id,
    users.username,
    users.firstname,
    users.lastname,
    users.password,
    users.email,
    users.phone,
    users.usertype,
    users.creator,
    users.createtime,
    user_type.type
FROM users
JOIN user_type ON users.usertype = user_type.id;

CREATE OR REPLACE VIEW order_items_info AS
SELECT
    order_items.id,
    order_items.itemid,
    order_items.itemname,
    order_items.price,
    order_items.discount,
    order_items.price * (100 - order_items.discount) / 100 AS curprice,
    order_items.itemnumber,
    order_items.status,
    order_items.orderid,
    order_status.status AS statusname
FROM order_items
JOIN order_status ON order_status.id = order_items.status;

CREATE OR REPLACE VIEW orders_info AS
SELECT
    a.id,
    a.paid,
    a.tablenumber,
    a.ordertime,
    a.creator,
    a.status,
    a.finishtime,
    a.total_quantity,
    a.total_amount,
    os.status AS statusname
FROM (
    SELECT
        o.id,
        o.paid,
        o.tablenumber,
        o.ordertime,
        o.creator,
        o.status,
        o.finishtime,
        SUM(i.itemnumber) AS total_quantity,
        ROUND(SUM(i.itemnumber * i.price * (1 - i.discount / 100.0))::NUMERIC, 2) AS total_amount
    FROM orders o
    JOIN order_items_info i ON o.id = i.orderid
    GROUP BY o.id, o.tablenumber, o.ordertime, o.creator, o.status, o.finishtime, o.paid
) a
JOIN order_status os ON a.status = os.id;

-- --------------------------------------------------------
-- STORED PROCEDURE
-- --------------------------------------------------------

CREATE OR REPLACE FUNCTION SelectTopItemsByType(N INTEGER)
RETURNS TABLE (
    itemid INTEGER,
    itemname VARCHAR,
    picture VARCHAR,
    foodtype INTEGER,
    typename VARCHAR,
    total_number BIGINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ranked.itemid,
        ranked.itemname,
        ranked.picture,
        ranked.foodtype,
        ranked.typename,
        ranked.total_number
    FROM (
        SELECT
            oi.itemid,
            oi.itemname,
            mi.picture,
            mi.foodtype,
            mi.typename,
            SUM(oi.itemnumber)::BIGINT AS total_number,
            ROW_NUMBER() OVER (
                PARTITION BY mi.foodtype
                ORDER BY SUM(oi.itemnumber) DESC
            ) AS rn
        FROM order_items oi
        JOIN menu_info mi ON oi.itemid = mi.id
        WHERE mi."itemAvailable" = TRUE
        GROUP BY oi.itemid, oi.itemname, mi.foodtype
    ) ranked
    WHERE ranked.rn <= N
    ORDER BY ranked.foodtype, ranked.total_number DESC;
END;
$$ LANGUAGE plpgsql;

-- --------------------------------------------------------
-- Reset sequences
-- --------------------------------------------------------
SELECT setval('deleted_images_id_seq', COALESCE((SELECT MAX(id) FROM deleted_images), 0));
SELECT setval('food_type_id_seq', COALESCE((SELECT MAX(id) FROM food_type), 0));
SELECT setval('users_id_seq', COALESCE((SELECT MAX(id) FROM users), 0));
SELECT setval('menu_id_seq', COALESCE((SELECT MAX(id) FROM menu), 0));
SELECT setval('orders_id_seq', COALESCE((SELECT MAX(id) FROM orders), 0));
SELECT setval('order_items_id_seq', COALESCE((SELECT MAX(id) FROM order_items), 0));
SELECT setval('reservations_id_seq', COALESCE((SELECT MAX(id) FROM reservations), 0));

COMMIT;