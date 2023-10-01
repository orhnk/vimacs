local M = {}

M.opts = function()
  return {
    setup = {
      -- Directory which contains all of your projects
      project_path = "~/Github/repos", -- TODO: Ask for user input + migrate to init.lua
    },

    templates = {
      {
        name = "Kotlin (Android)",
        repo = "nekocode/create-android-kotlin-app",
        opts = {
          pull = true,
        },
      },
      {
        name = "Java",
        repo = "pascalpoizat/template-java-project",
        opts = {
          pull = true,
        },
      },
      {
        name = "Swift",
        repo = "vapor/template",
        opts = {
          pull = true,
        },
      },
      {
        name = "TypeScript (React + Next.js)",
        repo = "cruip/open-react-template",
        opts = {
          pull = true,
        },
      },
      {
        name = "C# (.NET)",
        repo = "Dotnet-Boxed/Templates",
        opts = {
          pull = true,
        },
      },
      {
        name = "Go (Kratos)",
        repo = "go-kratos/kratos-layout",
        opts = {
          pull = true,
        },
      },
      {
        name = "Go (Makefile)",
        repo = "thockin/go-build-template",
        opts = {
          pull = true,
        },
      },
      {
        name = "R",
        repo = "KentonWhite/ProjectTemplate",
        opts = {
          pull = true,
        },
      },
      {
        name = "Markdown",
        repo = "othneildrew/Best-README-Template",
        opts = {
          pull = true,
        },
      },
      {
        name = "Python",
        repo = "rochacbruno/python-project-template",
        opts = {
          pull = true,
        },
      },

      {
        name = "Python (Tensorflow)",
        repo = "MrGemy95/Tensorflow-Project-Template",
        opts = {
          pull = true,
        },
      },

      {
        name = "Rust",
        expand = "cargo init",
      },

      {
        name = "C++",
        repo = "UTFeight/Cpp-Cmake-Template",
        opts = {
          pull = true,
        },
      },
    },
  }
end

return M
