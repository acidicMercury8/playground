import { IMonoid } from "./IMonoid";

export class Series<T> {
    constructor(private values: T[]) {
    }

    reduce(monoid: IMonoid<T>): T {
        let result: T = monoid.zero();
        for (let i = 0; i < this.values.length; i++) {
            result = monoid.op(result, this.values[i]);
        }
        return result;
    }
}
