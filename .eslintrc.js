module.exports = {
  env: {
    es6: true,
    node: true,
    browser: true,
  },
  extends: [
    'airbnb',
    'plugin:react/recommended',
    'plugin:@typescript-eslint/recommended',
  ],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
  },
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 2018,
    sourceType: 'module',
  },
  plugins: [
    'react',
    '@typescript-eslint',
    'import',
    'react-hooks',
  ],
  globals: {
    "document": false
  },
  settings: {
    "import/parsers": {
      "@typescript-eslint/parser": [".ts", ".tsx"],
    },
    "import/resolver": {
      "typescript": {
        "alwaysTryTypes": true
      }
    },
    "react": {
      "version": "detect"
    }
  },
  rules: {
    "import/extensions": [
      "error",
      "ignorePackages",
      {
        "js": "never",
        "jsx": "never",
        "ts": "never",
        "tsx": "never",
      },
    ],
    "react/jsx-filename-extension": [1, {"extensions": [".jsx", ".tsx"]}],
    "import/no-extraneous-dependencies": ["error", {"devDependencies": ["**/*.test.ts", "**/*.test.tsx", "**/*.config.js"]}],
    "lines-between-class-members": ["error", "always", { exceptAfterSingleLine: true }],
    "react/prop-types": 0,
    "no-plusplus": ["error", {allowForLoopAfterthoughts: true}],
    "no-mixed-operators": ["error", {
      groups: [
        ["&", "|", "^", "~", "<<", ">>", ">>>"],
        ["==", "!=", "===", "!==", ">", ">=", "<", "<="],
        ["&&", "||"],
        ["in", "instanceof"],
      ],
    }],
    "@typescript-eslint/no-explicit-any": 0,
    "semi": "off",
    "@typescript-eslint/semi": ["error"],
    "@typescript-eslint/camelcase": "off",
    "react-hooks/rules-of-hooks": "error",
    "react-hooks/exhaustive-deps": "warn",
  },
};
