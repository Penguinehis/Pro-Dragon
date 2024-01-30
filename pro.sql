-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 21/10/2023 às 22:40
-- Versão do servidor: 10.6.12-MariaDB-0ubuntu0.22.04.1
-- Versão do PHP: 8.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `cakepro`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `contato` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `mb` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `byid` int(11) NOT NULL,
  `mainid` int(11) NOT NULL,
  `accesstoken` varchar(255) NOT NULL DEFAULT '0',
  `valorrevenda` decimal(10,2) NOT NULL DEFAULT 0.00,
  `valorusuario` decimal(10,2) NOT NULL DEFAULT 0.00,
  `nivel` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Despejando dados para a tabela `accounts`
--

INSERT INTO `accounts` (`id`, `nome`, `contato`, `login`, `token`, `mb`, `senha`, `byid`, `mainid`, `accesstoken`, `valorrevenda`, `valorusuario`, `nivel`) VALUES
(1, 'Admin', '', 'admin', '', '', '123456', 0, 0, '', 0.00, 0.00, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `api_online`
--

CREATE TABLE `api_online` (
  `id` int(11) UNSIGNED NOT NULL,
  `byid` int(11) NOT NULL,
  `login` varchar(250) NOT NULL,
  `limite` varchar(250) NOT NULL,
  `start_time` datetime NOT NULL,
  `online` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atlasdeviceid`
--

CREATE TABLE `atlasdeviceid` (
  `id` int(11) UNSIGNED NOT NULL,
  `nome_user` int(11) NOT NULL,
  `byid` int(11) NOT NULL,
  `deviceid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atribuidos`
--

CREATE TABLE `atribuidos` (
  `id` int(11) UNSIGNED NOT NULL,
  `valor` varchar(255) DEFAULT NULL,
  `categoriaid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `byid` int(11) NOT NULL,
  `limite` int(11) NOT NULL,
  `limitetest` int(11) DEFAULT NULL,
  `tipo` varchar(255) NOT NULL,
  `expira` datetime DEFAULT NULL,
  `subrev` varchar(255) NOT NULL,
  `suspenso` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) UNSIGNED NOT NULL,
  `subid` int(11) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `subid`, `nome`) VALUES
(1, 1, 'default');

-- --------------------------------------------------------

--
-- Estrutura para tabela `config`
--

CREATE TABLE `config` (
  `id` int(11) UNSIGNED NOT NULL,
  `byid` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `maxtest` varchar(255) NOT NULL,
  `maxcredit` varchar(255) NOT NULL,
  `logo` varchar(500) NOT NULL,
  `maxtext` varchar(255) DEFAULT '12'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Despejando dados para a tabela `config`
--

INSERT INTO `config` (`id`, `byid`, `app`, `title`, `maxtest`, `maxcredit`, `logo`, `maxtext`) VALUES
(1, 1, 'seu link do aplicativo', 'PAINEL WEB PRO1', '120', '30', 'https://i.imgur.com/mqpTJPZ.png', '12');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cupom`
--

CREATE TABLE `cupom` (
  `id` int(11) UNSIGNED NOT NULL,
  `codigo` varchar(255) NOT NULL,
  `tipo` varchar(255) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_validade` datetime NOT NULL,
  `usos_maximos` int(11) NOT NULL,
  `usos_restantes` int(11) NOT NULL,
  `byid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `links`
--

CREATE TABLE `links` (
  `id` int(11) UNSIGNED NOT NULL,
  `link_id` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `short_link` varchar(255) NOT NULL,
  `byid` int(11) NOT NULL,
  `mainid` int(11) NOT NULL,
  `link_gerado` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `miracle_deviceid`
--

CREATE TABLE `miracle_deviceid` (
  `id` int(11) UNSIGNED NOT NULL,
  `userid` int(11) NOT NULL,
  `byid` int(11) NOT NULL,
  `device` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `id` int(11) UNSIGNED NOT NULL,
  `login` varchar(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_pagamento` datetime NOT NULL,
  `payment_id` varchar(255) NOT NULL,
  `byid` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `servidores`
--

CREATE TABLE `servidores` (
  `id` int(11) UNSIGNED NOT NULL,
  `subid` int(11) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `porta` varchar(255) DEFAULT NULL,
  `usuario` varchar(255) DEFAULT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `servercpu` varchar(255) NOT NULL DEFAULT 'NULL',
  `serverram` varchar(255) NOT NULL DEFAULT 'NULL',
  `onlines` int(11) NOT NULL DEFAULT 0,
  `lastview` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ssh_accounts`
--

CREATE TABLE `ssh_accounts` (
  `id` int(11) UNSIGNED NOT NULL,
  `byid` int(11) NOT NULL,
  `categoriaid` int(11) NOT NULL,
  `limite` int(11) NOT NULL,
  `bycredit` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `mainid` int(11) NOT NULL,
  `expira` datetime DEFAULT NULL,
  `lastview` datetime DEFAULT NULL,
  `nivel` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabela_bloqueio`
--

CREATE TABLE `tabela_bloqueio` (
  `id` int(11) UNSIGNED NOT NULL,
  `byid` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `data_bloqueio` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `api_online`
--
ALTER TABLE `api_online`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `atlasdeviceid`
--
ALTER TABLE `atlasdeviceid`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `atribuidos`
--
ALTER TABLE `atribuidos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `cupom`
--
ALTER TABLE `cupom`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `links`
--
ALTER TABLE `links`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `miracle_deviceid`
--
ALTER TABLE `miracle_deviceid`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servidores`
--
ALTER TABLE `servidores`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `ssh_accounts`
--
ALTER TABLE `ssh_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tabela_bloqueio`
--
ALTER TABLE `tabela_bloqueio`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `api_online`
--
ALTER TABLE `api_online`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=415;

--
-- AUTO_INCREMENT de tabela `atlasdeviceid`
--
ALTER TABLE `atlasdeviceid`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atribuidos`
--
ALTER TABLE `atribuidos`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cupom`
--
ALTER TABLE `cupom`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `links`
--
ALTER TABLE `links`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `miracle_deviceid`
--
ALTER TABLE `miracle_deviceid`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `servidores`
--
ALTER TABLE `servidores`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `ssh_accounts`
--
ALTER TABLE `ssh_accounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tabela_bloqueio`
--
ALTER TABLE `tabela_bloqueio`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
