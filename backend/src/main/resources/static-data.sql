INSERT INTO participants_role_ns (name) VALUES ('방장'), ('스태프'), ('일반');

INSERT INTO authority (authority_name) VALUES ('ROLE_USER');
INSERT INTO authority (authority_name) VALUES ('ROLE_ADMIN');

INSERT INTO user (email, name, password, nickname, activated) VALUES ('admin@email.com', 'admin', '$2a$08$lDnHPz7eUkSi6ao14Twuau08mzhWrL4kyZGGU5xfiGALO/Vxd5DOi', 'admin', 1);
INSERT INTO user (email, name, password, nickname, activated) VALUES ('user@email.com', 'user', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'user', 1);

INSERT INTO user_authority (user_no, authority_name) VALUES (1, 'ROLE_USER');
INSERT INTO user_authority (user_no, authority_name) VALUES (1, 'ROLE_ADMIN');
INSERT INTO user_authority (user_no, authority_name) VALUES (2, 'ROLE_USER');