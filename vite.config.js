import { defineConfig, loadEnv } from 'vite';
import laravel from 'laravel-vite-plugin';

export default ({ mode }) => {
    process.env = Object.assign(process.env, loadEnv(mode, process.cwd(), ''));

    return defineConfig({
        plugins: [
            laravel({
                input: ['resources/css/app.scss', 'resources/js/app.js'],
                refresh: true,
            }),
        ],
        server: {
            port:  process.env.VITE_PORT
        }
    });
}
