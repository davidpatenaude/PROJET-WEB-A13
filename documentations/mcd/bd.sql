# script crŽŽ le : Sun Sep 15 20:20:36 EDT 2013 -   syntaxe MySQL ;

# use  VOTRE_BASE_DE_DONNEE ;

DROP TABLE IF EXISTS users ;
CREATE TABLE users (user_id int AUTO_INCREMENT(10) NOT NULL,
user_username VARCHAR(50),
user_password VARCHAR(50),
user_first_name VARCHAR(50),
user_last_name VARCHAR(64),
user_role VARCHAR(20),
user_created DATETIME,
user_modified DATETIME,
user_email VARCHAR(64),
usermeta_id INT(10),
PRIMARY KEY (user_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS posts ;
CREATE TABLE posts (post_id int AUTO_INCREMENT(10) NOT NULL,
post_date DATETIME,
post_modified DATETIME,
post_title TEXT,
post_content LONGTEXT,
post_type VARCHAR(20),
post_status VARCHAR(20),
post_comment_status VARCHAR(20),
post_parent INT(10),
post_comment_count INT(10),
postmeta_id INT(10),
user_id INT(10),
PRIMARY KEY (post_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS postmeta ;
CREATE TABLE postmeta (postmeta_id int AUTO_INCREMENT(10) NOT NULL,
postmeta_key VARCHAR(255),
postmeta_value LONGTEXT,
post_id INT(10),
PRIMARY KEY (postmeta_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS comments ;
CREATE TABLE comments (comment_id int AUTO_INCREMENT(10) NOT NULL,
comment_created DATETIME,
comment_content TEXT,
comment_approved VARCHAR(20),
comment_parent INT(10),
commentmeta_id INT(10) NOT NULL,
user_id INT(10) NOT NULL,
post_id INT(10) NOT NULL,
PRIMARY KEY (comment_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS usermeta ;
CREATE TABLE usermeta (usermeta_id int AUTO_INCREMENT(10) NOT NULL,
usermeta_key VARCHAR(255),
usermeta_value LONGTEXT,
user_id INT(10),
PRIMARY KEY (usermeta_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS commentmeta ;
CREATE TABLE commentmeta (commentmeta_id int AUTO_INCREMENT(10) NOT NULL,
commentmeta_key VARCHAR(255),
commentmeta_value LONGTEXT,
comment_id INT(10),
PRIMARY KEY (commentmeta_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS term_taxonomy ;
CREATE TABLE term_taxonomy (term_taxonomy_id int AUTO_INCREMENT(10) NOT NULL,
taxonomy VARCHAR(32),
description LONGTEXT,
parent INT(10),
term_id INT(10),
PRIMARY KEY (term_taxonomy_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS terms ;
CREATE TABLE terms (term_id int AUTO_INCREMENT(10) NOT NULL,
name VARCHAR(200),
term_group INT(10),
PRIMARY KEY (term_id) ) ENGINE=InnoDB;

DROP TABLE IF EXISTS term_relationships ;
CREATE TABLE term_relationships (post_id int AUTO_INCREMENT(10) NOT NULL,
term_taxonomy_id INT(10) NOT NULL,
PRIMARY KEY (post_id,
 term_taxonomy_id) ) ENGINE=InnoDB;

ALTER TABLE users ADD CONSTRAINT FK_users_usermeta_id FOREIGN KEY (usermeta_id) REFERENCES usermeta (usermeta_id);

ALTER TABLE posts ADD CONSTRAINT FK_posts_postmeta_id FOREIGN KEY (postmeta_id) REFERENCES postmeta (postmeta_id);
ALTER TABLE posts ADD CONSTRAINT FK_posts_user_id FOREIGN KEY (user_id) REFERENCES users (user_id);
ALTER TABLE postmeta ADD CONSTRAINT FK_postmeta_post_id FOREIGN KEY (post_id) REFERENCES posts (post_id);
ALTER TABLE comments ADD CONSTRAINT FK_comments_commentmeta_id FOREIGN KEY (commentmeta_id) REFERENCES commentmeta (commentmeta_id);
ALTER TABLE comments ADD CONSTRAINT FK_comments_user_id FOREIGN KEY (user_id) REFERENCES users (user_id);
ALTER TABLE comments ADD CONSTRAINT FK_comments_post_id FOREIGN KEY (post_id) REFERENCES posts (post_id);
ALTER TABLE usermeta ADD CONSTRAINT FK_usermeta_user_id FOREIGN KEY (user_id) REFERENCES users (user_id);
ALTER TABLE commentmeta ADD CONSTRAINT FK_commentmeta_comment_id FOREIGN KEY (comment_id) REFERENCES comments (comment_id);
ALTER TABLE term_taxonomy ADD CONSTRAINT FK_term_taxonomy_term_id FOREIGN KEY (term_id) REFERENCES terms (term_id);
ALTER TABLE term_relationships ADD CONSTRAINT FK_term_relationships_post_id FOREIGN KEY (post_id) REFERENCES posts (post_id);
ALTER TABLE term_relationships ADD CONSTRAINT FK_term_relationships_term_taxonomy_id FOREIGN KEY (term_taxonomy_id) REFERENCES term_taxonomy (term_taxonomy_id);
