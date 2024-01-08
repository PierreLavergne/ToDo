/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `todos` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "todos_name_key" ON "todos"("name");
