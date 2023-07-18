provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = local.tags
  }
}

# 全リージョン操作する際のprovider設定

# 以下のリージョンは有効化しない限り管理対象にする必要はない
# af-south-1 アフリカ (ケープタウン)
# ap-east-1 アジアパシフィック (香港)
# eu-south-1 欧州 (ミラノ)
# me-south-1 中東 (バーレーン)
# See also https://docs.aws.amazon.com/general/latest/gr/rande-manage.html

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ap-northeast-2"
  region = "ap-northeast-2"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ap-northeast-1"
  region = "ap-northeast-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "ca-central-1"
  region = "ca-central-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "eu-west-2"
  region = "eu-west-2"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "eu-west-3"
  region = "eu-west-3"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "eu-north-1"
  region = "eu-north-1"
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
  default_tags {
    tags = local.tags
  }
}
