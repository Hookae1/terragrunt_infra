locals {
  ### Generall variables reusing through all modules in present environment
  env_id                    = "dev"
  region_id                 = "eu-west-2"
  project_id                = "grunt"
  maintainer                = "yurii.rybitskyi@coaxsoft.com"

  ### EC2 module variables
  ec2_instance_type         = "t4g.micro"
  ec2_public_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1EaEgOnBfCNxJhFAISKghB1TfrD6IyencZYNesm4dhrxCuOXr5ZYPAIpZWNrOMnB7kkBuGaT9KcG4y/lc9iKGMla+bnXMAU3QUz+U7TLhZATu94NYZLkoqFJgh2TXWFj+XLeLMX2tIM+NSu/qL6W12EzzR+Fb5dCHrVMHPurHCQarnm7vLC+qTCk+kEYxeoPiEcSx9dJ034nCekOYk/QbTl44XvliPr7Qpztw4DKR2tc6iYASgN3sVXHotK/7c1zk8pwI8Pf+B/mDTn0Jl8ylnfaHWHuxoCLXbwWmZozg68kqNS5a3IYsgNsaV1FC14UtJ46U36BOcM3dVgIo67nLvHohzmC45pf5zkXKtpWcGrDROdkF6VRJTJ5LcOzy3i0r8QezKb7MZSbj5uT8fGWUUVtKg3nwWqBKczSbyoYkYC19WJ1yGacavZAf9s8lSudRxwiAiia49Z3VQvBEWiGSB7bQHJ4dMM/6Ysx/G4Yrs1k2fdgJMLgXmU1L8vO32A3HVctT12zexzmrwIEfx/+sDfNu1pttbWwnulg4oUSpDSg+vaNlsQHmt2xrIDA+kBxTFCcwjrFjWgKsrgXJbIwORguaovy71wBfqWJkUfppn574NoTzxAEyuBHsGcFZvAzpcYOwxL43YzYOzM/D0KNIFr5zetJk+JDAbAHydbOhyw== yurii.rybitskyi@coaxsoft.com"

  ### IAM module variables
  

  ### Route 53 module variables
  domain                    = "grunt-test.tk"
  
}