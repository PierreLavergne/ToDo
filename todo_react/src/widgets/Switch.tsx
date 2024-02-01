import React, { useState } from 'react';
import '../styles/colors.css';
import '../styles/switch.css';

interface SwitchProps {
    onChange: CallableFunction;
}


const Switch: React.FC<SwitchProps> = ({onChange}) => {
    const [isOn, setIsOn] = useState(false);

    const toggleSwitch = () => {
        setIsOn(!isOn);
        onChange();
    };

    return (
        <label className="switch">
            <input type="checkbox" checked={isOn} onChange={toggleSwitch} />
            <span className="slider round"></span>
        </label>
    );
};

export default Switch;
