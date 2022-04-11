return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        select = { 'tsconfig.json', 'package.json', '.eslintrc', 'prettierrc.json' },
      },
    },
  },
}
