import React, { ChangeEventHandler } from 'react';
import '../styles/colors.css'; // Import your CSS file
import '../styles/input.css'; // Import your CSS file

interface InputProps {
  placeholder?: string;
  type?: 'text' | 'date';
  onChange?: ChangeEventHandler<HTMLInputElement>;
}

const Input: React.FC<InputProps> = ({  placeholder = '', type, onChange }) => {


  return (
    <input
      className={`input`}
      placeholder={placeholder}
      onChange={onChange}
      type={type}
      
    />
  );
};

export default Input;
