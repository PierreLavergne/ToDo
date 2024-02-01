import React from 'react';
import '../styles/colors.css'; // Import your CSS file
import '../styles/input.css'; // Import your CSS file

interface InputProps {
  placeholder?: string;
  onChange?: (event: React.ChangeEvent<HTMLInputElement>) => void;
}

const Input: React.FC<InputProps> = ({  placeholder = '', onChange }) => {


  return (
    <input
      className={`input`}
      placeholder={placeholder}
      onChange={onChange}
    />
  );
};

export default Input;
