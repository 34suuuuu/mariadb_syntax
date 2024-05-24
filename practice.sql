create database shoppingmall;
CREATE TABLE user(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255), 
    email VARCHAR(255) UNIQUE, 
    password VARCHAR(255) NOT NULL,
    role enum('user', 'seller'),
    delete_yn enum('N', 'Y') NOT NULL
    );

-- 판매자
-- 
-- seller : product -> 1:n
-- CREATE TABLE seller(
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(255),
--     email VARCHAR(255) UNIQUE,
--     password VARCHAR(255) NOT NULL
-- );

CREATE TABLE product(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255), 
    price INT,
    product_image TEXT,
    seller_id INT,
    FOREIGN KEY(seller_id) REFERENCES user(id)
    );
describe product;

-- orderlist : order_detail -> 1:n
CREATE TABLE orderlist(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_user_id INT,
    total_price INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(order_user_id) REFERENCES user(id)
    );

CREATE TABLE order_detail(
    order_id INT,
    order_product VARCHAR(255),
    order_count INT DEFAULT 0,
    FOREIGN KEY(order_id) REFERENCES orderlist(order_id)
);


-- 상품정보조회
-- 수정 필요
DELIMITER  //
CREATE PROCEDURE 상품정보조회()
BEGIN
    declare userName varchar(255);
    select u.name into userName from user u inner join product p on u.id = p.seller_id;
    SELECT P.product_name 물품명, P.price 가격, P.count 재고, userName
    FROM product p INNER JOIN user u ON p.seller_id = u.id; 
    select userName;
END
// DELIMITER ;

-- 주문상세조회 