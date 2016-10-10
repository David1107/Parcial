CREATE database databaseD;
USE databaseD;
CREATE TABLE parcial(
id INT NOT NULL AUTO_INCREMENT, 
PRIMARY KEY(id),
 name VARCHAR(30));
INSERT INTO parcial (name) VALUES ('David');
-- http://www.linuxhomenetworking.com/wiki/index.php/Quick_HOWTO_:_Ch34_:_Basic_MySQL_Configuration
GRANT ALL PRIVILEGES ON *.* to 'icesi'@'192.168.131.21' IDENTIFIED by '12345';
