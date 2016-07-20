shared dynamic ExpressApp {
    shared formal void use(Anything path, Anything handler=null);
    shared formal void listen(Integer port, String host, Anything() handler);
}

shared dynamic MbaasExpress {
    shared formal dynamic sys(dynamic endpoints);
    shared formal Anything mbaas;
    shared formal Anything fhmiddleware();
    shared formal Anything errorHandler();
}

shared dynamic Router {
    shared formal void use(Anything x);
    "Adds a new HTTP handler for GET"
    shared formal void get(String path, Anything(Request, Response) f);
    shared formal void post(String path, Anything(Request, Response) f);
}

shared dynamic Request {
    shared formal dynamic query;
    shared formal dynamic body;
}
shared dynamic Response {
    shared formal void json(dynamic obj);
}
