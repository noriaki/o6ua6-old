import es6Promise from 'es6-promise';
import superagentPromisePlugin from 'superagent-promise-plugin';
import superagent from 'superagent';

es6Promise.polyfill();
const request = superagentPromisePlugin.patch(superagent);

const defaultHeaders = {
  Accept: 'application/json',
  'Content-type': 'application/json',
};

class Api {
  constructor(client = request) {
    this.client = client;
  }

  vote({ winner, loser }, headers = defaultHeaders) {
    const data = `${winner.identifier}/${loser.identifier}`;
    return this.client
      .post('/vote')
      .set(headers)
      .send(JSON.stringify({ data }));
  }
}

export default Api;
