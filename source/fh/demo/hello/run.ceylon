import express { express }
import cors { cors }
import fh.mbaas.api { mbaasExpress }
import my.express { ... }

shared void run() {
    value port = parseInteger(process.environmentVariableValue("FH_PORT") else
        process.environmentVariableValue("OPENSHIFT_NODEJS_PORT") else
    "Missing option") else 8001;
    value host = process.environmentVariableValue("OPENSHIFT_NODEJS_IP") else
    "0.0.0.0";
    ExpressApp app;
    MbaasExpress mbExpress;
    dynamic {
        app = express();
        mbExpress = mbaasExpress();
        // Enable CORS for all requests
        app.use(cors());
        // list the endpoints which you want to make securable here
        dynamic securableEndpoints = dynamic [ "/hello" ];
        // Note: the order which we add middleware to Express here is important!
        app.use("/sys", mbExpress.sys(securableEndpoints));
    }
    app.use("/mbaas", mbExpress.mbaas);
    // allow serving of static files from the public directory
    //app.use(express.static(__dirname+"/public"));
    // Note: important that this is added just before your own Routes
    app.use(mbExpress.fhmiddleware());
    app.use("/hello", helloRoute());
    // Important that this is last!
    app.use(mbExpress.errorHandler());
    app.listen(port, host,
        () => print("App listening on port ``port``")
    );
}