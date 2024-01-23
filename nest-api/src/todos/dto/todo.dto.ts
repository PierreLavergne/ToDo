import { ApiProperty } from '@nestjs/swagger';
import { TodoPriority } from '@prisma/client';
import { IsDateString, IsEnum, IsNotEmpty, IsString } from 'class-validator';

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
  @IsDateString()
  deadline: Date;

  @ApiProperty()
  @IsNotEmpty()
  @IsEnum(TodoPriority)
  label: TodoPriority;
}
