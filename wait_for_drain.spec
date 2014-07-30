Name:           wait_for_drain
Version:        0.1.0
Release:        1
Summary:        cli utility for watching for connections to drain

Group:          Applications/Internet
License:        GPLv3
URL:            https://github.com/gregswift/%{name}
Source0:        %{name}.tar.gz
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      noarch

Requires:       python

%description
A simple cli implementation that watches an IP:PORT combination
to determine if active connections have gone away.

This is a stand alone implementation of a functionality that has been
submitted to Ansible as enhancement to the wait_for module. I strongly
recommend using Ansible in the long run, over this function.

%prep
%setup -q -n %{name}


%build


%install
rm -rf %{buildroot}
mkdir -p %{buildroot}%{_bindir}
cp %{name} %{buildroot}%{_bindir}


%clean
rm -rf %{buildroot}


%files
%defattr(0755,root,root,-)
%{_bindir}/%{name}


%changelog
* Wed Jul 30 2014 Greg Swift <gregswift@gmail.com> 0.1.0-1
- initial rpm build
