create database app_clothes;

use app_clothes;

-- Table for Users (including Admins)
CREATE TABLE user (
    id_user INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    avatar LONGBLOB NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    address TEXT NULL,
    gender ENUM('male', 'female') null,
    birthday DATE NULL,
    resetPasswordToken TEXT,
    resetPasswordExpires DATETIME
);

-- Table for Products
CREATE TABLE product (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    person nvarchar(255) not null,
    material TEXT,
    overview TEXT,
    price DECIMAL(20, 2) NOT NULL,
    img_url longblob not null,
    type nvarchar(255) not null
);

-- Table for Orders
CREATE TABLE order (
    id_order INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT,
    status ENUM('pending', 'processing', 'completed', 'cancelled') DEFAULT 'pending',
    order_date datetime,
    completed_date datetime,
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);

-- Table for Order Items
CREATE TABLE order_item (
    id_order_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_order INT,
    id_product INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    address INT NOT NULL,
    phone_number INT NOT NULL,
    FOREIGN KEY (id_order) REFERENCES `order`(id_order),
    FOREIGN KEY (id_product) REFERENCES product(id_product)
);

-- Table for Carts
CREATE TABLE cart (
    id_cart INT AUTO_INCREMENT PRIMARY KEY not null,
    id_user INT,
    FOREIGN KEY (id_user) REFERENCES user(id_user)
);

-- Table for Cart Items
CREATE TABLE cart_item (
    id_cart_detail INT AUTO_INCREMENT PRIMARY KEY not null,
    id_cart INT,
    id_product INT,
    quantity INT NOT NULL,
    FOREIGN KEY (id_cart) REFERENCES cart(id_cart),
    FOREIGN KEY (id_product) REFERENCES product(id_product)
);

CREATE TABLE payment (
  id_payment SERIAL PRIMARY KEY,
  id_order INT NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  payment_method ENUM ('banking', 'cash') NOT NULL,
  payment_date TIMESTAMP,
  status ENUM ('pending', 'completed', 'fail', 'cancelled') NOT NULL,
  payment_link TEXT,
  FOREIGN KEY (id_order) REFERENCES order (id_order)
);

CREATE TABLE favorite (
		id_favorite INT AUTO_INCREMENT PRIMARY KEY not null,
		id_user INT,
		id_product INT,
		FOREIGN KEY (id_user) REFERENCES user(id_user),
		FOREIGN KEY (id_product) REFERENCES product(id_product)
	);
