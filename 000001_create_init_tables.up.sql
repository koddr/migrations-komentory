-- Add UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set timezone
-- For more information, please visit:
-- https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
SET TIMEZONE="Europe/Moscow";

-- Create users table
CREATE TABLE "users" (
  "id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp,
  "email" varchar(255) UNIQUE NOT NULL,
  "password_hash" varchar(64) NOT NULL,
  "username" varchar(18) UNIQUE NOT NULL,
  "user_status" int NOT NULL DEFAULT (0),
  "user_role" varchar(32) NOT NULL,
  "user_attrs" JSONB NOT NULL
);

-- Create projects table
CREATE TABLE "projects" (
  "id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp,
  "user_id" UUID NOT NULL REFERENCES "users" ("id") ON DELETE CASCADE,
  "alias" varchar(24) UNIQUE NOT NULL,
  "project_status" int NOT NULL DEFAULT (0),
  "project_attrs" JSONB NOT NULL
);

-- Create tasks table
CREATE TABLE "tasks" (
  "id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp,
  "user_id" UUID NOT NULL REFERENCES "users" ("id") ON DELETE CASCADE,
  "project_id" UUID NOT NULL REFERENCES "projects" ("id") ON DELETE CASCADE,
  "task_status" int NOT NULL DEFAULT (0),
  "task_attrs" JSONB NOT NULL
);

-- Create answers table
CREATE TABLE "answers" (
  "id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp,
  "user_id" UUID NOT NULL REFERENCES "users" ("id") ON DELETE CASCADE,
  "project_id" UUID NOT NULL REFERENCES "projects" ("id") ON DELETE CASCADE,
  "task_id" UUID NOT NULL REFERENCES "tasks" ("id") ON DELETE CASCADE,
  "answer_status" int NOT NULL DEFAULT (0),
  "answer_attrs" JSONB NOT NULL
);

-- Create users index
CREATE INDEX "active_users" ON "users" ("id", "email", "username") WHERE "user_status" = 1;

-- Create projects index
CREATE INDEX "active_projects" ON "projects" ("alias") WHERE "project_status" = 1;

-- Create tasks index
CREATE INDEX "active_tasks" ON "tasks" ("id") WHERE "task_status" = 1;

-- Create answers index
CREATE INDEX "active_answers" ON "answers" ("id") WHERE "answer_status" = 1;