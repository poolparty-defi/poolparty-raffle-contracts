const compilers = {
    solc: {
        version: "^0.8.9",
        docker: false,
        parser: "solcjs",
        settings: {
            optimizer: {
                enabled: true, //env.
                runs: 200 //env.
            },
            emvVersion: "instanbul" //env.
        }
    }

};

module.exports = {
    compilers
};