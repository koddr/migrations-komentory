.PHONY: migrate.up migrate.down migrate.force

migrate.up:
	migrate -path $(PWD) -database "$(db_url)" up

migrate.down:
	migrate -path $(PWD) -database "$(db_url)" down

migrate.force:
	migrate -path $(PWD) -database "$(db_url)" force $(version)