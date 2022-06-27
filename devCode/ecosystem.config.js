module.exports = {
    apps : [{
        name: 'nodejs-sw-api-pm2', 
        script    : "./bin/www", 
        cwd  : "./API",
        instances : 1, 
        merge_logs: true,
        autorestart: true,
        exec_mode : "cluster",
        time : true
    },{
        name: 'nextjs-sw-web-pm2', 
        script    : "./server.js", 
        cwd  : "./web",
        instances : 1, 
        merge_logs: true,
        autorestart: true,
        exec_mode : "cluster",
        time : true
    }]
}