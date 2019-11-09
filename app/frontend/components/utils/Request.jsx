import React from 'react'
import { message } from 'antd';

class Request {
    get = (url, options = {}) => {
        let queryString = this._objToQueryString(options.data);

        return fetch(`${url}?${queryString}`, {
            method: "GET"
        })
          .then(response => this._handleResponseStatue(response))
          .catch((error) => {
              throw error
          });
    };

    post = (url, options = {}) => {

    };

    delete = (url, options = {}) => {
        let opts = { method: "DELETE" };
        if(options.headers){
            opts.headers = options.headers
        }
        return fetch(url, opts)
          .then(response => this._handleResponseStatue(response))
    };

    put = (url, options = {}) =>{

    };

    patch = (url, options = {}) =>{

    };

    _handleResponseStatue = (response) => {
        if(response.status === 204){
            return response
        }else if(response.status >= 200 && response.status < 300){
            return response.json()
        }else{
            message.error(response.statusText);
            throw new Error(response.statusText)
        }
    };

    _objToQueryString = (obj = {}) => {
        const ary = [];
        for (const key in obj) {
            ary.push(encodeURIComponent(key) + '=' + encodeURIComponent(obj[key]));
        }
        return ary.join('&');
    }
}
const ajax = new Request()
export default ajax;
