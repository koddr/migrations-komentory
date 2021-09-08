.PHONY: migrate.up migrate.down migrate.force

local_db_url = postgres://postgres:password@localhost:5432/postgres?sslmode=disable

migrate.up:
	migrate -path $(PWD) -database "$(db_url)" up

migrate.down:
	migrate -path $(PWD) -database "$(db_url)" down

migrate.force:
	migrate -path $(PWD) -database "$(db_url)" force $(version)

migrate.local.up:
	migrate -path $(PWD) -database "$(local_db_url)" up

migrate.local.down:
	migrate -path $(PWD) -database "$(local_db_url)" down

migrate.local.force:
	migrate -path $(PWD) -database "$(local_db_url)" force $(version)