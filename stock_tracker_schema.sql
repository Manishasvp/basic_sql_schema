CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE portfolio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ticker VARCHAR(10),
    quantity INT,
    purchase_price DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE alerts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    ticker VARCHAR(10),
    target_price DECIMAL(10, 2),
    triggered BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (username, password)
VALUES ('john_doe', 'hashed_password_here');

SELECT * FROM users
WHERE username = 'john_doe' AND password = 'hashed_password_here';

INSERT INTO portfolio (user_id, ticker, quantity, purchase_price)
VALUES (1, 'AAPL', 10, 155.00);

SELECT ticker, quantity, purchase_price
FROM portfolio
WHERE user_id = 1;

UPDATE portfolio
SET quantity = 15, purchase_price = 152.00
WHERE user_id = 1 AND ticker = 'AAPL';

DELETE FROM portfolio
WHERE user_id = 1 AND ticker = 'AAPL';

INSERT INTO alerts (user_id, ticker, target_price)
VALUES (1, 'TSLA', 900.00);

SELECT * FROM alerts
WHERE triggered = FALSE AND target_price <= 900;

UPDATE alerts
SET triggered = TRUE
WHERE user_id = 1 AND ticker = 'TSLA' AND target_price <= 900;

DELETE FROM alerts
WHERE user_id = 1 AND ticker = 'TSLA';

SELECT u.username, p.ticker, p.quantity, p.purchase_price
FROM users u
JOIN portfolio p ON u.id = p.user_id;

SELECT u.username, a.ticker, a.target_price, a.triggered
FROM users u
JOIN alerts a ON u.id = a.user_id;
