# ProdAPP

> Aplicativo para produtores rurais — gestão de silos, dicionário de pragas, calendário de plantio, rotação de culturas, descarte de defensivos e notícias do agronegócio.

Este repositório contém **duas versões** do mesmo aplicativo:

| Versão | Pasta | Plataforma | Linguagem | Status |
|---|---|---|---|---|
| **1.x — Legado** | `app/` | Android (SDK 25, 2017) | Java | Mantido para referência histórica |
| **2.x — Flutter** | `flutter_app/` | Android + iOS | Dart | **Atual / em desenvolvimento** |

A versão 2.x é uma refatoração completa preservando o design e todas as funcionalidades da versão original, agora multiplataforma e construída sobre stack moderna.

---

## Sumário

- [Visão geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Arquitetura](#arquitetura)
- [Design system](#design-system)
- [Stack técnica](#stack-técnica)
- [Estrutura de pastas](#estrutura-de-pastas)
- [Como rodar](#como-rodar)
- [Banco de dados](#banco-de-dados)
- [Credenciais de teste](#credenciais-de-teste)
- [Migração do Java para o Flutter](#migração-do-java-para-o-flutter)
- [Roadmap](#roadmap)
- [Versão legado (Android Java)](#versão-legado-android-java)

---

## Visão geral

O ProdAPP nasceu como um projeto de aplicativo voltado a pequenos e médios produtores rurais brasileiros, oferecendo módulos práticos para o dia-a-dia da propriedade. A primeira versão foi escrita em Java para Android com SDK 25 (Android 7.1), em 2017. O código original foi preservado em `app/` e reescrito do zero em Flutter, sob o diretório `flutter_app/`, sem perder nenhuma funcionalidade — e modernizando partes da experiência (animações, theming Material 3, suporte a iOS, navegação fluida).

---

## Funcionalidades

### Autenticação local
- Login com e-mail e senha (validados contra base SQLite local).
- Opção de manter a sessão ativa (substitui o `SharedPreferences` da versão Java).
- Cadastro de novos usuários com confirmação de e-mail e senha.

### Menu central
- Hub principal com cartões coloridos para cada módulo.
- Drawer lateral com header em gradiente verde (logo + e-mail do usuário) e atalhos para todos os módulos.

### Gestão de silos
- Listagem em grade dos silos do usuário com indicador percentual de ocupação.
- Cadastro de silo com nome, produto armazenado (Arroz, Milho, Soja, Trigo) e capacidade em litros.
- Tela de detalhe com **termômetro vertical de 10 segmentos** — modernização das 10 *toolbars* do layout original — exibindo a porcentagem ocupada visualmente.
- Operações: adicionar/remover quantidade (+100, +1000, -100) e remoção do silo com confirmação.

### Dicionário de pragas
- Submenu por cultura (Arroz, Milho, Soja, Trigo).
- Lista de pragas catalogadas para cada cultura.
- Tela de detalhe com **nome científico, descrição da ameaça e manejo recomendado** — texto técnico revisado em relação ao app original.

### Calendário de plantio
- Lista das quatro culturas principais com a janela ideal de plantio.
- Detalhamento por cultura: janela, região indicada, solo recomendado e observações técnicas (inoculante, zoneamento, vazio sanitário etc.).

### Rotação de culturas
- Seleção via *FilterChips* de até 8 culturas (Arroz, Milho, Soja, Trigo, Girassol, Milhete, Sorgo, Tremoço).
- **Geração dinâmica de diagrama circular** com setas indicando a sequência sugerida — substitui os gráficos estáticos da versão original.
- Tela de "Informações complementares" com princípios de manejo.

### Descarte de defensivos
- Tutorial em 4 passos para o **descarte correto de embalagens vazias** (tríplice lavagem, inutilização, armazenamento, devolução).
- Lista de pontos de descarte (centrais inPEV, recebedores credenciados, revendas).

### Notícias do agronegócio
- Feed organizado por fornecedor (Agroeste, Dekalb, Dimicron, Sementes Estrela).
- Cada fornecedor abre uma lista de cards com imagem, título e resumo.

### Sincronização (stub)
- Tela funcional pronta para conectar a um backend remoto.
- A versão atual simula a sincronização com feedback visual; o ponto de integração está marcado no código (`features/sync/sync_screen.dart`).

### Dúvidas / FAQ
- Lista expansível (*ExpansionTile*) com perguntas frequentes sobre o app.

### Lista de usuários
- Visualização administrativa de usuários cadastrados localmente.

---

## Arquitetura

A versão Flutter adota uma arquitetura em camadas simples, pragmática para o porte do projeto:

```
┌─────────────────────────────────────────────────────────┐
│  features/<modulo>/  Telas + lógica de apresentação     │
│  shared/widgets/     Widgets reutilizáveis (Scaffold,   │
│                      Drawer, Cartão de ação…)           │
│  shared/static_data/ Catálogos imutáveis (pragas,       │
│                      épocas, notícias)                  │
│  data/repositories/  Acesso a dados (Sessão + SQLite)   │
│  data/db/            DatabaseHelper (criação + seed)    │
│  data/models/        Modelos imutáveis (Usuario, Silo)  │
│  core/theme/         Paleta + ThemeData por seção       │
│  core/router/        Roteamento por rotas nomeadas      │
│  main.dart           Bootstrap + decisor de rota        │
└─────────────────────────────────────────────────────────┘
```

**Decisões:**
- Sem framework pesado de DI/estado — `StatefulWidget` + `FutureBuilder` cobrem a complexidade atual.
- Cada *feature* é independente; rotear novas telas exige apenas adicionar um caso ao `AppRouter`.
- Dados estáticos (pragas, épocas) viraram constantes em `shared/static_data/` para facilitar versionamento.
- O *DatabaseHelper* faz *seed* inicial preservando o usuário e silo padrão da versão Java (`prodapp@gmail.com` / `prodapp`).

---

## Design system

A identidade visual da versão original foi preservada **integralmente** — incluindo a paleta cromática semântica por seção. Cada módulo continua com sua cor de assinatura, herdada do `colors.xml` do projeto Android.

| Seção | Cor | Hex |
|---|---|---|
| Central / Login | Verde claro | `#98CD65` |
| Silos | Azul | `#4A84E1` |
| Usuário / Sobre | Laranja | `#E4A943` |
| Notícias | Verde médio | `#99CC66` |
| Calendário | Coral | `#EA5E54` |
| Descarte | Roxo | `#AA66CC` |
| Rotação | Magenta | `#D45ED2` |
| Pragas | Teal | `#53BCBE` |
| Sincronização | Lavanda | `#A883D4` |

**AppBars temáticos:** o widget `ScaffoldSecao` recebe um `SecaoTema` e aplica automaticamente o `ThemeData` da seção (cor primária, *AppBar*, botões, *FAB*). Isso reproduz, em Flutter, o comportamento dos `TemaMenu*` definidos no `styles.xml` original.

**Outros tokens:**
- Botão padrão: cinza claro (`#D6D7D7`) com texto preto bold — mantido fiel ao `PadraoBotao` da versão Java.
- Tipografia: Roboto (padrão Flutter), com tamanhos 24/18/16/14 sp.
- *Cards* com cantos 10 px e elevação suave (substituem os `LinearLayout` com padding manual).
- Drawer com header gradient `#81C784 → #4CAF50 → #2E7D32` (preservado do layout original).

**Ícones:** o conjunto de PNGs de culturas, pragas, descarte, gráficos e logos foi copiado de `app/src/main/res/drawable/` para `flutter_app/assets/images/`, garantindo continuidade visual.

---

## Stack técnica

| Camada | Versão original (Java) | Versão Flutter |
|---|---|---|
| Linguagem | Java 8 | Dart 3 |
| Plataforma | Android (SDK 17–25) | Android + iOS (mesma base) |
| UI | XML layouts + AppCompat | Flutter / Material 3 |
| Persistência local | SQLite (`SQLiteOpenHelper`) | SQLite (`sqflite`) |
| Preferências | `SharedPreferences` | `shared_preferences` |
| Navegação | Intents + Activities | Rotas nomeadas (`MaterialPageRoute`) |
| Build | Gradle 2.x | Flutter SDK 3.11+ |

**Dependências principais (Flutter):**
- `sqflite` — banco SQLite local
- `path` / `path_provider` — caminhos de arquivos
- `shared_preferences` — sessão persistente
- `provider` — disponível para crescimento futuro
- `intl` — formatação localizada

---

## Estrutura de pastas

```
prodApp/
├── app/                          # Versão 1.x — Android Java (legado)
│   ├── build.gradle
│   └── src/main/
│       ├── AndroidManifest.xml
│       ├── java/                 # Activities, BD, Adapters, Modelos
│       └── res/                  # Layouts, drawables, strings, styles
│
├── flutter_app/                  # Versão 2.x — Flutter (atual)
│   ├── pubspec.yaml
│   ├── assets/images/            # Assets migrados do projeto Android
│   ├── lib/
│   │   ├── main.dart
│   │   ├── core/
│   │   │   ├── theme/            # AppColors, AppTheme, SecaoTema
│   │   │   └── router/           # AppRouter (rotas nomeadas)
│   │   ├── data/
│   │   │   ├── db/               # DatabaseHelper (sqflite)
│   │   │   ├── models/           # Usuario, Silo
│   │   │   └── repositories/     # UsuarioRepository, SiloRepository, Sessao
│   │   ├── features/
│   │   │   ├── auth/             # Login, Cadastro, ListaUsuarios
│   │   │   ├── menu/             # MenuCentral
│   │   │   ├── silos/            # Lista, Cadastro, Detalhe
│   │   │   ├── pragas/           # SubMenu, Cultura, Detalhe
│   │   │   ├── calendario/       # Lista épocas, detalhe por cultura
│   │   │   ├── rotacao/          # Diagrama dinâmico + detalhes
│   │   │   ├── descarte/         # Menu, Como, Onde
│   │   │   ├── noticias/         # Hub + por fornecedor
│   │   │   ├── sync/             # Sincronização (stub)
│   │   │   └── faq/              # Perguntas frequentes
│   │   └── shared/
│   │       ├── widgets/          # ScaffoldSecao, CartaoAcao, DrawerLateral
│   │       └── static_data/      # cultura, pragas, epocas, noticias
│   └── test/
│       └── widget_test.dart
│
├── build.gradle                  # Gradle raiz (versão legado)
├── gradle/                       # Wrapper Gradle (versão legado)
└── README.md
```

---

## Como rodar

### Pré-requisitos
- Flutter SDK **3.11+** ([instalação](https://docs.flutter.dev/get-started/install))
- Android Studio com Android SDK (para emulador) **ou** Xcode (para iOS)
- `flutter doctor` sem alertas críticos

### Passos

```bash
# 1. Entre no projeto Flutter
cd flutter_app

# 2. Baixe as dependências
flutter pub get

# 3. Liste dispositivos disponíveis
flutter devices

# 4. Rode em modo debug
flutter run                       # dispositivo padrão
flutter run -d <id-do-device>     # dispositivo específico

# 5. (opcional) Build de release
flutter build apk --release       # Android APK
flutter build appbundle --release # Google Play AAB
flutter build ios --release       # iOS (requer macOS)
```

### Análise estática e testes

```bash
flutter analyze     # análise do código
flutter test        # roda a bateria de testes
```

---

## Banco de dados

A versão Flutter mantém compatibilidade conceitual com o esquema da versão Java:

| Tabela | Colunas |
|---|---|
| `usuarios` | `id_usuario` (PK, auto), `nome_usuario`, `email_usuario` (unique), `senha_usuario` |
| `silos` | `id_silo` (PK, auto), `id_usuario` (FK), `nome_silo`, `produto_silo`, `tamanho_silo`, `quantidade_atual` |

**Novidade:** a coluna `quantidade_atual` foi adicionada para que o silo passe a guardar quanto há armazenado naquele momento — algo que a versão original mantinha em memória / via tabela `valor` separada.

O *seed* inicial preserva os dados originais:
- Usuário `prodapp@gmail.com` / senha `prodapp`
- Silo "ProdaPP" (Trigo, 25.000 L, 5.000 L armazenados)

---

## Credenciais de teste

| Campo | Valor |
|---|---|
| E-mail | `prodapp@gmail.com` |
| Senha | `prodapp` |

Novos usuários podem ser cadastrados pela tela "Cadastrar-se" na própria tela de login.

---

## Migração do Java para o Flutter

Mapeamento entre as principais *Activities* da versão 1.x e as telas Flutter:

| Activity (Java) | Tela Flutter |
|---|---|
| `TelaDeLogin` | `features/auth/login_screen.dart` |
| `TelaDeCadastro` | `features/auth/cadastro_screen.dart` |
| `MenuCentral` | `features/menu/menu_central_screen.dart` |
| `MenuLateralActivity` | `shared/widgets/drawer_lateral.dart` |
| `ListaSilos` | `features/silos/lista_silos_screen.dart` |
| `TelaCadastroSilos` | `features/silos/cadastro_silo_screen.dart` |
| `SiloPrincipal` / `TelaDeDetalhesDoSilo` / `TelaDeGerenciamentoDeSilo` | `features/silos/silo_detalhe_screen.dart` (unificadas) |
| `SubMenuPragas` | `features/pragas/pragas_screens.dart` → `SubMenuPragasScreen` |
| `SubSubMenu[Arroz/Milho/Soja]` + `Praga[Cultura][1/2]` | `PragasCulturaScreen` + `PragaDetalheScreen` (template único) |
| `TelaEpocasDePlantacao` + `TelaEpocaDe[Cultura]` | `features/calendario/calendario_screens.dart` |
| `TelaDeRotacaoDeCultura` + `ZoomGrafico[1/2]` | `features/rotacao/rotacao_screen.dart` (diagrama dinâmico via `CustomPainter`) |
| `TelaRotacaoDeCulturaMaisDetalhes` | `RotacaoDetalhesScreen` |
| `TelaColetaAgrotoxicos` | `features/descarte/descarte_screens.dart` → `DescarteMenuScreen` |
| `TelaComoDescartar` | `ComoDescartarScreen` |
| `TelaOndeDescartar` + `ZoomDescarte[1/2]` | `OndeDescartarScreen` |
| `TelaDeNovidades` | `features/noticias/noticias_screens.dart` → `NoticiasScreen` |
| `Noticia[Agroeste/Deklab/Dimicron/SementesEstrela]` | `NoticiasFornecedorScreen` (template único) |
| `TelaDeSincronizacao` | `features/sync/sync_screen.dart` |
| `TelaDePerguntasESobre` | `features/faq/faq_screen.dart` |
| `ListaUsuarios` | `features/auth/lista_usuarios_screen.dart` |

**Resumo da consolidação:** o app Java tinha **24+ Activities**. A versão Flutter usa **≈12 telas** + *templates* genéricos parametrizados por `Cultura` ou `Fornecedor` — eliminando duplicação sem perder nenhuma rota lógica.

### Melhorias incorporadas
- **Diagrama de rotação dinâmico** desenhado via `CustomPainter` (versão Java tinha gráficos estáticos em PNG).
- **Termômetro de 10 segmentos** substitui as 10 toolbars empilhadas no XML original.
- **Templates genéricos** para Pragas/Notícias/Calendário — adicionar uma cultura nova requer apenas editar um `Map` em `shared/static_data/`.
- **Validação robusta** de formulários (com mensagens do `strings.xml` original preservadas).
- **Drawer unificado** disponível em todas as telas via `ScaffoldSecao`.
- **Material 3** com `ColorScheme.fromSeed` por seção, garantindo cores derivadas consistentes (text, ripple, disabled etc.).

---

## Roadmap

- [ ] Sincronização real com backend remoto (substituir stub).
- [ ] Recuperação de senha via e-mail.
- [ ] Histórico de movimentações por silo (gráfico temporal).
- [ ] Localização (i18n) — pt-BR + es + en.
- [ ] Tema escuro.
- [ ] Modo offline com fila de operações pendentes.
- [ ] Conteúdo de pragas/notícias gerenciado por CMS.
- [ ] Testes de integração cobrindo os principais fluxos.

---

## Versão legado (Android Java)

A pasta `app/` contém o projeto Android original. Os requisitos para compilar essa versão são bastante antigos e podem exigir um ambiente legado:

- Android Studio 2.3 (ou superior, com suporte a Gradle 2.x)
- Android SDK Build Tools **25.0.2**
- compileSdk **25**, minSdk **17**, targetSdk **25**

Para abrir, importe `prodApp/` no Android Studio. Possíveis ajustes necessários em ambientes modernos:
- Atualizar `gradle-wrapper.properties` para uma versão compatível.
- Migrar dependências `compile`/`testCompile` para `implementation`/`testImplementation`.
- Atualizar `support-v4`/`appcompat-v7` para AndroidX.

A versão legado **não recebe mais alterações** — toda evolução acontece em `flutter_app/`.

---

## Licença

Projeto acadêmico. Uso pessoal/educacional. Para uso comercial, contate o autor.
