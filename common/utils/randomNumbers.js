/**
 * Generate an array of random numbers
 * @param {number} [length=10] - Length of the returned array
 * @returns {number[]} - Array of random numbers between 0 and 9
 */
export default (length = 10) => Array.from({ length }, () => Math.floor(Math.random() * 10));
