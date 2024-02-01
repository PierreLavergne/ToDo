import React, { useState } from 'react';
import '../styles/colors.css';
import '../styles/switch.css';

const Switch: React.FC = () => {
    const [isOn, setIsOn] = useState(false);

    const toggleSwitch = () => {
        setIsOn(!isOn);
    };

    return (
        <label className="switch">
            <input type="checkbox" checked={isOn} onChange={toggleSwitch} />
            <span className="slider round"></span>
        </label>
    );
};

export default Switch;
