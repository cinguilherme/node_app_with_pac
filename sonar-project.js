const sonarqubeScanner = require('sonarqube-scanner');
sonarqubeScanner({
    serverUrl: 'http://192.168.0.17:9000',
    options : {
        'sonar.sources': '.',
        'sonar.inclusions' : 'packages/core/src/**' // Entry point of your code
    }
}, () => {});
