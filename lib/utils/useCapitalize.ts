export const useCapitalize = () => {
  const capitalize = (str: string) => {
    if (str.length === 0) {
      return str;
    }
    const words = str.split(/[\s_]+/);
    const capitalizedWords = words.map((word) => word.charAt(0).toUpperCase() + word.slice(1));
    return capitalizedWords.join('');
  };

  return { capitalize };
};
