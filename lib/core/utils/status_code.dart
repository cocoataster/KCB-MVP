enum StatusCode {
  informational,
  success,
  redirection,
  clientError,
  serverError
}

StatusCode getStatusCode(int code) {
  if (code >= 100 && code < 200) {
    return StatusCode.informational;
  } else if (code >= 200 && code < 300) {
    return StatusCode.success;
  } else if (code >= 300 && code < 400) {
    return StatusCode.redirection;
  } else if (code >= 400 && code < 500) {
    return StatusCode.clientError;
  } else {
    return StatusCode.serverError;
  }
}
