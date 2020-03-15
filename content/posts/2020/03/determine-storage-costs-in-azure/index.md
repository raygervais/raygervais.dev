---
title: Determing Average Storage Costs via Azure with Python
published: true
date: 2020-03-09
tags: ["Open Source", "Python", "Azure", "Microsoft", "Analytics", "DevOps"]
cover_image: ./images/pawel-czerwinski-M8NGA7njt2w-unsplash.jpg
description: "About a month ago, a photographer (and filmmaker in the making) friend approached me about hosting in Azure a copy of his media for safekeeping, and wanted to also understand an average cost over time as they'd add more files to the Storage Account. Funnily enough, this is a small application script that I had written before for the green office, along with a script that I had integrated into one of my monthly to-be-automated tasks here in the red office. I figured I's share the Simple Python script, seeing that despite some of the excellent documentation provided by Microsoft, there are multiple ways to approach the solution which can easily be mangled and confused with other solutions and recommendations."
---

_Enabling you to say "I saved us $3,000 per subscription!" with ease._

About a month ago, a photographer (and filmmaker in the making) friend approached me about hosting in Azure a copy of his media for safekeeping, and wanted to also understand an average cost over time as they'd add more files to the Storage Account. Funnily enough, this is a small application script that I had written before for the green office, along with a script that I had integrated into one of my monthly to-be-automated tasks here in the red office. I figured I's share the Simple Python script, seeing that despite some of the excellent documentation provided by Microsoft, there are multiple ways to approach the solution which can easily be mangled and confused with other solutions and recommendations. It took me two days of work to get it all working together nicely, having scoured Stackoverflow and documentation sites all pointing to their _"solutions"_ without specifying SDK version etc. So, let's go over a coherent working method that I provided my friend for them to utilize as they traverse and leverage Azure in their media-creation process.

## Getting Setup

_Requirements_:

- Python3.7
- Pip
- Virtualenv

With the above requirements installed, use the following commands to setup the dependencies that we'll need for this:

```shell
# Default to using python3.7, modify path to your local py3.7 install
virtualenv -p /usr/local/bin/python3.7 venv

# Activate the virtual environment
source ./venv/bin/activate

# Install requirements
pip install 'azure-storage-blob==12.2.0'
pip install 'azure-mgmt-resource==2.2.0'
pip install 'azure-mgmt-storage==2.0.0'
pip install 'azure-common==1.1.24'
```

## The Script:

_So, let's break down what the script is doing to achieve our analytic requirements. I will note now, that I haven't tested this script against a valid subscription since rewriting it to accommodate this post, so there may be a typo-friendo along the way. We'll ignore and fix those as they come up!_

```python
# Script AverageCostPerMonth.py
# Version: 1.1
# Usage: python3.7 AverageCostPerMonth.py

from azure.common.credentials import ServicePrincipalCredentials
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.storage.blob import BlobServiceClient, ContainerClient

# Globals (REPLACE WITH YOURS)
TENANT = ""
CLIENT_ID = ""
SECRET = ""
SUBSCRIPTION_ID = ""
RESOURCE_GROUP_NAME = ""
STORAGE_ACCOUNT_NAME = ""
CONTAINER_NAME = ""
FILE_FILE_EXTENSION = ".raw"

# Functional Helpers
def pretty_size(bytes):
    units = [
        (1<<50, ' PB'),
        (1<<40, ' TB'),
        (1<<30, ' GB'),
        (1<<20, ' MB'),
        (1<<10, ' KB'),
        (1, (' byte', ' bytes'))
    ]

    for factor, suffix in units:
        if bytes >= factor:
            break
        amount = int(bytes/factor)

    if isinstance(suffix, tuple):
        singular, multiple = suffix
        if amount == 1:
            suffix = singular
        else:
        suffix = multiple

    return str(amount) + suffix

def average_cost(bytes, cost_average):
    return (bytes / (1 << 30 )) * cost_average

def format_row():
    return " {:80} {:25} \n".format

if __name__ == '__main__':
    # Authenticate against ServicePrincipal
    credentials = ServicePrincipalCredentials(tenant=TENANT, client_id=CLIENT_ID, secret=SECRET)

    # Create Storage Client
    storage_client = StorageManagementClient(credentials, SUBSCRIPTION_ID)

    # Retrieve Storage Account Keys
    storage_keys = storage_client.storage_accounts.list_keys(RESOURCE_GROUP_NAME, STORAGE_ACCOUNT_NAME)
    storage_keys = { v.key_name: v.value for v in storage_keys.keys }

    # Create Container Client, Grant it 20 second lease
    blob_service_client = BlobServiceClient("https://{}.blob.core.windows.net".format(STORAGE_ACCOUNT_NAME), credentials=storage_keys["key1"])
    container_service = blob_service_client.get_container_client(CONTAINER_NAME)
    container_service.acquire_lease(20)

    # Retrieve Blobs
    blobs = container_service.list_blobs()
    archive = [blob for blob in blobs]
    archive_size = sum(blob.size for blob in archive)

    # Print Stats
    print(format_row("Name", "Size"))

    for blob in archive:
        print(format_row(blob.name, pretty_size(blob.size)))

    print(f"\n\nTotal Size: {pretty_size(archive_size)}")
    print(f"\nAverage Monthly Cost: ${average_cost(archive_size, 0.015)}")
```

**Let's go over some of the functional-style helpers that I wrote to help keep the script clean:**

- For this version, I opted for brevity to make all the dynamic variables that would be useful to have as proper command-line arguments as global constant variables. These are used throughout the script and should never be committed to a repository (public or private).
- The `pretty_size` function was taken from [ccpizza's Stackoverflow answer](https://stackoverflow.com/questions/5194057/better-way-to-convert-file-sizes-in-python), and allows for us to convert bytes to petabytes, with all the magic in-between.
- the `average_cost` function is a simple GB \* cost_average calculation, utilizing the bytes to GB formula to match Azure's \$0.015/GB pricing scheme.
- the `format_row` function is a neat little trick I learned on Stackoverflow (cannot find the link, will go through work-computer when I have the chance) to print out tables without having to worry about multiple format calls etc. You can see me calling it by the end of the script for final output of the blobs found in the Storage Account.

## Resources

- [Cover Image: Photo by Paweł Czerwiński on Unsplash](https://unsplash.com/photos/M8NGA7njt2w)
- [Microsoft AzureSDK for Python](https://github.com/Azure/azure-sdk-for-python)
- [Microsoft Docs: Install AzureSDK for Python](https://docs.microsoft.com/en-us/azure/python/python-sdk-azure-install)
- [azure-storage-blobs V12](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-python)
