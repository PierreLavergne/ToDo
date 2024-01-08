-- CreateEnum
CREATE TYPE "todo_priority" AS ENUM ('Low', 'Medium', 'Important', 'Urgent');

-- CreateTable
CREATE TABLE "todos" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "label" "todo_priority" NOT NULL,

    CONSTRAINT "todos_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "todos_id_key" ON "todos"("id");
