# Movies

O projeto consiste em apresentar uma listagem de filmes onde o usuário poderá favoritar um filme e visualizar uma listagem com os filmes favoritados.

## Overview

### Arquitetura

A arquitetura que será utilizada no projeto será a MVP (Model, View e Presenter).

#### Model
Essa camada contém a regra de negócio da aplicação.

#### View
Essa camada é responsavel pelos os elementos da interface gráfica, ela se comunica apenas com a camada presenter.

#### Presenter
Essa camada ficará responsável por intermediar a comunicasção da View com a camada Model.

### Ferramentas

- [Carthage](https://github.com/Carthage/Carthage) para gerenciamento de dependências
- [Xcodegen](https://github.com/yonaskolb/XcodeGen) para gerar o arquivo .xcproject
- [Fastlane](https://fastlane.tools) para automatização de fluxos
- [swift-format](https://github.com/google/swift/tree/format) para manter uma formatação consistente no projeto
- [Swiftgen](https://github.com/SwiftGen/SwiftGen) para gerar código para acessarmos Assets/Colors/Strings de forma tipáda.
- [SwiftyMocky](https://github.com/MakeAWishFoundation/SwiftyMocky) para geração de Mocks pra utilizarmos nos testes.
- [Slather](https://github.com/SlatherOrg/slather) para análise da cobertura de código.