import { ApiProperty } from '@nestjs/swagger';
import { TodoPriority } from '@prisma/client';
import { IsDate, IsEnum, IsNotEmpty, IsString, isDate } from 'class-validator';

export class TodoDTO {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsString()
  description?: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsDate()
  deadline: Date;

  @ApiProperty()
  @IsNotEmpty()
  @IsEnum(TodoPriority)
  label: TodoPriority;
}
