import React from 'react';
import '../styles/colors.css'; // Import your CSS file
import '../styles/customSelector.css'; // Import your CSS file

interface SelectProps {
    values: string[];
    onChange?: React.ChangeEventHandler<HTMLSelectElement>;
}

const Select: React.FC<SelectProps> = ({ values = [], onChange  }) => {


    return (
        <select onChange={onChange}>
            {values.map((value, index) => (
                <option key={index} value={value}>{value}</option>
            ))}
        </select>
    );
};

export default Select;