import es6Promise from 'es6-promise';
import superagentPromisePlugin from 'superagent-promise-plugin';
import superagent from 'superagent';

es6Promise.polyfill();
const request = superagentPromisePlugin.patch(superagent);

class Api {
  constructor(client = request) {
    this.client = client;
  }

  vote({ winner, loser }, headers = {}) {
    const data = `${winner.identifier}/${loser.identifier}`;
    return this.client
      .post('/vote')
      .type('json')
      .accept('json')
      .set(headers)
      .send({ data });
  }
}

export default Api;
