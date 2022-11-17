import { MaxTemperature } from "./MaxTemperature";
import { Series } from "./Series";

const s1 = new Series<[number, number]>([[1, 100], [2, 300], [3, 120]]);
const s2 = new Series<[number, number]>([[1, 100]]);
const s3 = new Series<[number, number]>([]);

const maxT = new MaxTemperature();

console.log(s1.reduce(maxT));
console.log(s2.reduce(maxT));
console.log(s3.reduce(maxT));
console.log(maxT.op(s1.reduce(maxT), s1.reduce(maxT)));
