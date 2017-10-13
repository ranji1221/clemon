--
--  lemon jersey auth moduel sql  -- MYSQL
--

-- user
Drop table  if exists lemon_jersey_auth_user;
CREATE TABLE lemon_jersey_auth_user (
  id int(11) NOT NULL auto_increment,
  create_time datetime ,
  archived tinyint(1) default '0',
  version int(11) DEFAULT 0,
  password varchar(255) not null,
  username varchar(255) not null unique,
  default_user tinyint(1) default '0',
  last_login_time datetime ,
  PRIMARY KEY  (id),
  INDEX username_index (username)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- role
Drop table  if exists lemon_jersey_auth_role;
CREATE TABLE lemon_jersey_auth_role (
  id int(11) NOT NULL auto_increment,
  archived tinyint(1) default '0',
  version int(11) DEFAULT 0,
  role_name varchar(255) not null,
  PRIMARY KEY  (id)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- user_role
Drop table  if exists lemon_jersey_auth_user_role;
CREATE TABLE lemon_jersey_auth_user_role (
  user_id int(11) not null,
  role_id int(11) not null,
  INDEX users_id_index (user_id),
  INDEX roles_id_index (role_id)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- role_permission
Drop table  if exists lemon_jersey_auth_role_permission;
CREATE TABLE lemon_jersey_auth_role_permission (
  role_id int(11) not null,
  permission varchar(255) not null,
  INDEX role_id_index (role_id)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


--
--  lemon jersey oauth2 moduel sql  -- MYSQL
--

Drop table  if exists lemon_jersey_oauth2_client;
create table lemon_jersey_oauth2_client (
  client_id VARCHAR(255) PRIMARY KEY,
  client_secret VARCHAR(255),
  client_name VARCHAR(255),
  client_uri VARCHAR(255),
  client_icon_uri VARCHAR(255),
  resource_ids VARCHAR(255),
  scope VARCHAR(255),
  grant_type VARCHAR(255),
  redirect_uri VARCHAR(255),
  roles VARCHAR(255),
  access_token_validity INTEGER default -1,
  refresh_token_validity INTEGER default -1,
  description VARCHAR(4096),
  create_time timestamp default now(),
  archived tinyint(1) default '0',
  trusted tinyint(1) default '0'
);

Drop table  if exists lemon_jersey_oauth2_access_token;
create table lemon_jersey_oauth2_access_token (
  create_time timestamp default now(),
  token_id VARCHAR(255) unique,
  token_expired_seconds INTEGER default -1,
  authentication_id VARCHAR(255),
  username VARCHAR(255),
  client_id VARCHAR(255),
  token_type VARCHAR(255),
  refresh_token_expired_seconds INTEGER default -1,
  refresh_token VARCHAR(255) unique
);

Drop table  if exists lemon_jersey_oauth2_access_token_code;
create table lemon_jersey_oauth2_access_token_code (
  create_time timestamp default now(),
  code VARCHAR(255) unique,
  username VARCHAR(255),
  client_id VARCHAR(255)
);






