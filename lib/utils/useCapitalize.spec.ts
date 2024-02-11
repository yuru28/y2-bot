import { useCapitalize } from './useCapitalize';

describe('useCapitalize()', () => {
  describe('capitalize()', () => {
    const { capitalize } = useCapitalize();
    const subject = (content: string) => {
      return capitalize(content);
    };

    describe('with single word string', () => {
      it('capitalizes the first letter of a string', () => {
        expect(subject('hello')).toEqual('Hello');
      });
    });

    describe('with multiple word string separated by underscores', () => {
      it('capitalizes the first letter of a string', () => {
        expect(subject('hello_world')).toEqual('HelloWorld');
      });
    });
  });
});
