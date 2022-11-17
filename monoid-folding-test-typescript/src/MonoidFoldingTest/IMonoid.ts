export interface IMonoid<T> {
    zero(): T;
    isZero(v: T): boolean;
    op(a: T, b: T): T;
}
