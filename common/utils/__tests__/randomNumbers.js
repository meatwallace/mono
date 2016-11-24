/* global describe it expect */
import randomNumbers from '../randomNumbers';

describe('randomNumbers', () => {
  it('should return an array of numbers', () => {
    expect(Array.isArray(randomNumbers())).toBe(true);
    expect(randomNumbers().every(num => typeof num === 'number')).toBe(true);
  });

  it('should return 10 entries by default', () => {
    expect(randomNumbers().length).toBe(10);
  });

  it('should accept a number as the first param, determining the quantity of entries', () => {
    expect(randomNumbers(20).length).toBe(20);
  });
});
