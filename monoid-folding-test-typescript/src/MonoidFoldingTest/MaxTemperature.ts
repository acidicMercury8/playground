import { IMonoid } from "./IMonoid";

export class MaxTemperature implements IMonoid<[number, number]> {
    zero(): [number, number] {
        return [0, 0];
    }

    isZero(v: [number, number]): boolean {
        const [time, value] = v;
        return time === 0 && value === 0;
    }

    op(a: [number, number], b: [number, number]): [number, number] {
        if (this.isZero(a)) {
            return b;
        }
        if (this.isZero(b)) {
            return a;
        }

        const [, aValue] = a;
        const [, bValue] = b;

        return aValue > bValue
            ? a
            : b;
    }
}
