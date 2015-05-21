{% from "solr_jetty/map.jinja" import solr_jetty_settings with context %}
solr_jetty:
  pkg.installed:
    - name: {{ solr_jetty_settings.package }}
  service.{{ solr_jetty_settings.jetty.state }}:
    - name: {{ solr_jetty_settings.service }}
    - enable: True

jetty_conf:
  file.managed:
    - name: {{ solr_jetty_settings.jetty.conf }}
    - template: jinja
    - source:  salt://solr_jetty/files/jetty.jinja
    - watch_in:
      - service: solr_jetty

{% if grains['oscodename'] == 'wheezy' %}
/var/lib/jetty/webapps/solr:
  file.symlink:
    - target: /usr/share/solr/web
{% endif %}
