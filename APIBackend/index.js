const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');
const {parse} = require('querystring');

const hostname = '34.73.27.60';
const port = 9999;

const publicDir = '/home/hughleeboy/parking/images'
const contentType = 'image/jpeg'
var number = -1;

const server = http.createServer((req, res) => {
	console.log("request------------------\n\t", req.method,"->",url.parse(req.url).pathname);
	if(req.method == 'GET'){
		const filename = url.parse(req.url).pathname;
		const filepath = path.join(publicDir, filename);
		console.log(filename);
		if(filepath.trim() == '/home/hughleeboy/parking/images/number'){
			res.setHeader('Content-Type', 'text/plain');
			//res.setHeader('Content-Length', stat.size);
			res.statusCode=200;
			res.write(number.toString(), () => {
				res.statusCode = 200;
				res.end();
			});
		}else{
			fs.exists(filepath, (exists) => {
				if(exists){
					const stat = fs.statSync(filepath);
					res.setHeader('Content-Type', contentType);
					res.setHeader('Content-Length', stat.size);
					res.statusCode=200;
					var readStream = fs.createReadStream(filepath);
					//console.log('size = ', stat.size);
					readStream.pipe(res);
					//res.end();
				}else{
					console.log(url.parse(req.url));
					console.log('image url(',filepath.trim(),') does not exist');
					res.statusCode=404;
					res.end();
				}
			});
		}
		//console.log(filename);
	}else if(req.method == 'POST'){
		const filename = url.parse(req.url).path;
		const filepath = path.join(publicDir, filename);
		res.statusCode=200;
	
		var body = '';
		req.on('data', function(chunk) {
			body += chunk;
		});
		req.on('end', () => {
			//console.log(body);
			let obj = JSON.parse(body);
			//console.log(Object.keys(obj));
			if(obj['image']!=undefined){
					let b64str = obj['image'];
					//console.log(b64str);
					let buff = new Buffer(b64str, 'base64');
					fs.writeFileSync(filepath, buff);
				}else if(obj['number']!=undefined){
					number = obj['number'];//global var
					console.log("number = ", number);

				}else{
					console.log('yikes theres no attribute that i know');
				}
		  
			res.statusCode=200;
			res.end();
		});

	}else{
		console.log('request type not get or post');
		res.write('please use get or post', () => {
			res.statusCode=200;
			res.end();
		})
	}
});

server.listen(port, () => {
	console.log(`Server Running on ${hostname}:${port}`);
});
