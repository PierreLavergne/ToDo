import axios from 'axios';

export const getTodos = async (isJava: boolean) => {
    console.log(`${import.meta.env.VITE_URLJAVA}`);
    const url = isJava ? `${import.meta.env.VITE_URLJAVA}/todos` : `${import.meta.env.VITE_URL}/todos`;
    try {
        const response = await axios.get(url);
        return response.data;
    } catch (error) {
        console.error(error);
        throw new Error('Failed to load todos');
    }
};

export const postTodos = async (todo: Record<string, string>, isJava: boolean) => {
    console.log(todo);
    const url = isJava ? `${import.meta.env.VITE_URLJAVA}/todos` : `${import.meta.env.VITE_URL}/todos`;
    try {
        const response = await axios.post(url, todo, {
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
    });
    return response.data;
    } catch (error) {
        console.error(error);
        throw new Error('Failed to update todo');
    }
};

export const putTodos = async (todo: Record<string, string>, isJava: boolean) => {
    const url = isJava ? `${import.meta.env.VITE_URLJAVA}/todos` : `${import.meta.env.VITE_URL}/todos`;
    try {
        const response = await axios.put(url, todo, {
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
    });
    return response.data;
    } catch (error) {
        console.error(error);
        throw new Error('Failed to update todo');
    }
};