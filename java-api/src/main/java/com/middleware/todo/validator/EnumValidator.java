package com.middleware.todo.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Documented
@Constraint(validatedBy = EnumValidatorConstraint.class)
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface EnumValidator {
	Class<? extends Enum<?>> enumClass();

	String message() default "must be any of enum {enum}";

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};
}
