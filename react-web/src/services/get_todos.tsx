import axios from 'axios';

export const getTodos = async (isJava: boolean) => {
    const url = isJava ? `${import.meta.env.VITE_JAVA_API_BASE_URL}/todos` : `${import.meta.env.VITE_NEST_API_BASE_URL}/todos`;
    try {
        const response = await axios.get(url);
        return response.data;
    } catch (error) {
        console.error(error);
        throw new Error('Failed to load todos');
    }
};

export const postTodos = async (todo: Record<string, string>, isJava: boolean) => {
    const url = isJava ? `${import.meta.env.VITE_JAVA_API_BASE_URL}/todos` : `${import.meta.env.VITE_NEST_API_BASE_URL}/todos`;
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
    const url = isJava ? `${import.meta.env.VITE_JAVA_API_BASE_URL}/todos` : `${import.meta.env.VITE_NEST_API_BASE_URL}/todos`;
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