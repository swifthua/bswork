CREATE TABLE STATUS (
	ZTID char(16),
	ZTMS char(16),
	SFJY float);
INSERT INTO STATUS VALUES (
	'1',
	'未审核',
	0);
INSERT INTO STATUS VALUES (
	'2',
	'已审核',
	0);
INSERT INTO STATUS VALUES (
	'3',
	'审核未通过',
	0);
INSERT INTO STATUS VALUES (
	'4',
	'审核通过',
	0);
INSERT INTO STATUS VALUES (
	'5',
	'待上级审核',
	0);
INSERT INTO STATUS VALUES (
	'6',
	'其他状态',
	0);
